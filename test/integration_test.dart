import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import '../lib/features/posts/data/data_sources/post_data_source.dart';
import '../lib/features/posts/data/repositories/post_repository_impl.dart';
import '../lib/features/posts/domain/use_cases/get_posts_use_case.dart';
import '../lib/features/posts/domain/entities/post.dart';
import '../lib/features/posts/data/models/post_model.dart';
import '../lib/core/resources/errors/failures.dart';

void main() {
  group('Posts Feature Integration Tests', () {
    late PostDataSourceImpl dataSource;
    late PostRepositoryImpl repository;
    late GetPostsUseCase useCase;

    setUp(() {
      dataSource = PostDataSourceImpl();
      repository = PostRepositoryImpl(dataSource);
      useCase = GetPostsUseCase(repository);
    });

    group('Complete Data Flow Integration', () {
      test(
        'should successfully retrieve posts through complete data flow',
        () async {
          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<Right<Failure, List<Post>>>());

          result.fold(
            (failure) =>
                fail('Expected success but got failure: ${failure.message}'),
            (posts) {
              expect(posts, isNotEmpty);
              expect(posts.length, equals(10));

              // Verify first post data
              final firstPost = posts.first;
              expect(firstPost.id, equals(1));
              expect(
                firstPost.title,
                equals('Introduction to Flutter Development'),
              );
              expect(
                firstPost.body,
                contains('Flutter is Google\'s UI toolkit'),
              );
              expect(firstPost.userId, equals(1));

              // Verify last post data
              final lastPost = posts.last;
              expect(lastPost.id, equals(10));
              expect(
                lastPost.title,
                equals('Navigation and Routing Best Practices'),
              );
              expect(lastPost.body, contains('Proper navigation structure'));
              expect(lastPost.userId, equals(3));
            },
          );
        },
      );

      test(
        'should verify data conversion from PostModel to Post entity works correctly',
        () async {
          // Act
          final result = await useCase.call();

          // Assert
          result.fold(
            (failure) =>
                fail('Expected success but got failure: ${failure.message}'),
            (posts) {
              for (final post in posts) {
                // Verify that all posts are Post entities (not PostModel)
                expect(post, isA<Post>());

                // Verify all required properties are present and valid
                expect(post.id, isA<int>());
                expect(post.id, greaterThan(0));
                expect(post.title, isA<String>());
                expect(post.title, isNotEmpty);
                expect(post.body, isA<String>());
                expect(post.body, isNotEmpty);
                expect(post.userId, isA<int>());
                expect(post.userId, greaterThan(0));
              }

              // Verify specific data integrity
              final postWithId5 = posts.firstWhere((post) => post.id == 5);
              expect(
                postWithId5.title,
                equals('Testing Strategies in Flutter'),
              );
              expect(postWithId5.userId, equals(2));
              expect(postWithId5.body, contains('Testing is crucial'));
            },
          );
        },
      );

      test('should handle network delay simulation correctly', () async {
        // Arrange
        final stopwatch = Stopwatch()..start();

        // Act
        final result = await useCase.call();

        // Assert
        stopwatch.stop();

        // Verify that the simulated delay was applied (should be at least 500ms)
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(500));

        // Verify the result is still successful
        expect(result, isA<Right<Failure, List<Post>>>());
      });

      test('should maintain data consistency across multiple calls', () async {
        // Act
        final result1 = await useCase.call();
        final result2 = await useCase.call();

        // Assert
        expect(result1, isA<Right<Failure, List<Post>>>());
        expect(result2, isA<Right<Failure, List<Post>>>());

        result1.fold(
          (failure) => fail('First call failed: ${failure.message}'),
          (posts1) {
            result2.fold(
              (failure) => fail('Second call failed: ${failure.message}'),
              (posts2) {
                // Verify both calls return the same data
                expect(posts1.length, equals(posts2.length));

                for (int i = 0; i < posts1.length; i++) {
                  expect(posts1[i].id, equals(posts2[i].id));
                  expect(posts1[i].title, equals(posts2[i].title));
                  expect(posts1[i].body, equals(posts2[i].body));
                  expect(posts1[i].userId, equals(posts2[i].userId));
                }
              },
            );
          },
        );
      });
    });

    group('Error Handling Integration', () {
      test(
        'should handle data source exceptions and return ServerFailure',
        () async {
          // Arrange - Create a data source that throws an exception
          final failingDataSource = _FailingPostDataSource();
          final failingRepository = PostRepositoryImpl(failingDataSource);
          final failingUseCase = GetPostsUseCase(failingRepository);

          // Act
          final result = await failingUseCase.call();

          // Assert
          expect(result, isA<Left<Failure, List<Post>>>());

          result.fold(
            (failure) {
              expect(failure, isA<ServerFailure>());
              expect(failure.message, contains('Simulated data source error'));
            },
            (posts) => fail(
              'Expected failure but got success with ${posts.length} posts',
            ),
          );
        },
      );

      test(
        'should propagate error messages correctly through all layers',
        () async {
          // Arrange
          const errorMessage = 'Network connection failed';
          final failingDataSource = _FailingPostDataSource(
            errorMessage: errorMessage,
          );
          final failingRepository = PostRepositoryImpl(failingDataSource);
          final failingUseCase = GetPostsUseCase(failingRepository);

          // Act
          final result = await failingUseCase.call();

          // Assert
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains(errorMessage));
          }, (posts) => fail('Expected failure but got success'));
        },
      );
    });

    group('Data Mapping Integration', () {
      test(
        'should correctly map all PostModel fields to Post entity fields',
        () async {
          // Act
          final result = await useCase.call();

          // Assert
          result.fold(
            (failure) =>
                fail('Expected success but got failure: ${failure.message}'),
            (posts) {
              // Test specific mapping scenarios
              final testCases = [
                {'id': 1, 'userId': 1, 'titleKeyword': 'Flutter'},
                {'id': 2, 'userId': 2, 'titleKeyword': 'Architecture'},
                {'id': 3, 'userId': 1, 'titleKeyword': 'BLoC'},
              ];

              for (final testCase in testCases) {
                final post = posts.firstWhere((p) => p.id == testCase['id']);
                expect(post.userId, equals(testCase['userId']));
                expect(post.title, contains(testCase['titleKeyword']));
              }
            },
          );
        },
      );

      test('should preserve data types during mapping', () async {
        // Act
        final result = await useCase.call();

        // Assert
        result.fold(
          (failure) =>
              fail('Expected success but got failure: ${failure.message}'),
          (posts) {
            for (final post in posts) {
              // Verify all fields maintain correct types after mapping
              expect(post.id, isA<int>());
              expect(post.title, isA<String>());
              expect(post.body, isA<String>());
              expect(post.userId, isA<int>());

              // Verify no null values
              expect(post.id, isNotNull);
              expect(post.title, isNotNull);
              expect(post.body, isNotNull);
              expect(post.userId, isNotNull);
            }
          },
        );
      });
    });

    group('Performance Integration', () {
      test('should complete data flow within reasonable time', () async {
        // Arrange
        const maxExpectedTime = 1000; // 1 second
        final stopwatch = Stopwatch()..start();

        // Act
        final result = await useCase.call();

        // Assert
        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, lessThan(maxExpectedTime));
        expect(result, isA<Right<Failure, List<Post>>>());
      });
    });
  });
}

// Helper class for testing error scenarios
class _FailingPostDataSource implements PostDataSource {
  final String errorMessage;

  _FailingPostDataSource({this.errorMessage = 'Simulated data source error'});

  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    throw Exception(errorMessage);
  }
}
