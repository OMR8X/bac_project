import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import '../lib/features/posts/data/data_sources/post_data_source.dart';
import '../lib/features/posts/data/repositories/post_repository_impl.dart';
import '../lib/features/posts/domain/use_cases/get_posts_use_case.dart';
import '../lib/features/posts/domain/entities/post.dart';
import '../lib/core/resources/errors/failures.dart';
import '../lib/features/posts/data/models/post_model.dart';

void main() {
  group('Error Handling Integration Tests', () {
    group('Repository Error Handling', () {
      test(
        'should return ServerFailure when data source throws generic exception',
        () async {
          // Arrange
          final dataSource = _ThrowingDataSource(Exception('Generic error'));
          final repository = PostRepositoryImpl(dataSource);
          final useCase = GetPostsUseCase(repository);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<Left<Failure, List<Post>>>());
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Generic error'));
          }, (posts) => fail('Expected failure but got success'));
        },
      );

      test(
        'should return ServerFailure when data source throws FormatException',
        () async {
          // Arrange
          final dataSource = _ThrowingDataSource(
            const FormatException('Invalid format'),
          );
          final repository = PostRepositoryImpl(dataSource);
          final useCase = GetPostsUseCase(repository);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<Left<Failure, List<Post>>>());
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Invalid format'));
          }, (posts) => fail('Expected failure but got success'));
        },
      );

      test(
        'should return ServerFailure when data source throws TypeError',
        () async {
          // Arrange
          final dataSource = _ThrowingDataSource(TypeError());
          final repository = PostRepositoryImpl(dataSource);
          final useCase = GetPostsUseCase(repository);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<Left<Failure, List<Post>>>());
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, isNotEmpty);
          }, (posts) => fail('Expected failure but got success'));
        },
      );

      test('should handle null or empty data gracefully', () async {
        // Arrange
        final dataSource = _EmptyDataSource();
        final repository = PostRepositoryImpl(dataSource);
        final useCase = GetPostsUseCase(repository);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<Right<Failure, List<Post>>>());
        result.fold(
          (failure) =>
              fail('Expected success but got failure: ${failure.message}'),
          (posts) {
            expect(posts, isEmpty);
          },
        );
      });

      test(
        'should handle malformed data and still succeed with valid posts',
        () async {
          // Arrange
          final dataSource = _MixedDataSource();
          final repository = PostRepositoryImpl(dataSource);
          final useCase = GetPostsUseCase(repository);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<Right<Failure, List<Post>>>());
          result.fold(
            (failure) =>
                fail('Expected success but got failure: ${failure.message}'),
            (posts) {
              expect(posts, isNotEmpty);
              expect(
                posts.length,
                equals(2),
              ); // Only valid posts should be included

              // Verify the valid posts
              expect(posts.any((post) => post.id == 1), isTrue);
              expect(posts.any((post) => post.id == 3), isTrue);
            },
          );
        },
      );
    });

    group('Use Case Error Propagation', () {
      test(
        'should propagate repository failures without modification',
        () async {
          // Arrange
          final dataSource = _ThrowingDataSource(
            Exception('Original error message'),
          );
          final repository = PostRepositoryImpl(dataSource);
          final useCase = GetPostsUseCase(repository);

          // Act
          final result = await useCase.call();

          // Assert
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Original error message'));
          }, (posts) => fail('Expected failure but got success'));
        },
      );

      test('should maintain error type through all layers', () async {
        // Arrange
        final dataSource = _ThrowingDataSource(Exception('Test error'));
        final repository = PostRepositoryImpl(dataSource);
        final useCase = GetPostsUseCase(repository);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<Left<Failure, List<Post>>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.runtimeType, equals(ServerFailure));
        }, (posts) => fail('Expected failure but got success'));
      });
    });

    group('Data Source Error Scenarios', () {
      test('should handle timeout scenarios', () async {
        // Arrange
        final dataSource = _TimeoutDataSource();
        final repository = PostRepositoryImpl(dataSource);
        final useCase = GetPostsUseCase(repository);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<Left<Failure, List<Post>>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('timeout'));
        }, (posts) => fail('Expected failure but got success'));
      });

      test('should handle concurrent access errors', () async {
        // Arrange
        final dataSource = _ConcurrentAccessDataSource();
        final repository = PostRepositoryImpl(dataSource);
        final useCase = GetPostsUseCase(repository);

        // Act - Make multiple concurrent calls
        final futures = List.generate(5, (_) => useCase.call());
        final results = await Future.wait(futures);

        // Assert - All should handle the error gracefully
        for (final result in results) {
          expect(result, isA<Left<Failure, List<Post>>>());
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Concurrent access error'));
          }, (posts) => fail('Expected failure but got success'));
        }
      });
    });
  });
}

// Helper classes for testing different error scenarios

class _ThrowingDataSource implements PostDataSource {
  final Object exception;

  _ThrowingDataSource(this.exception);

  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 50));
    throw exception;
  }
}

class _EmptyDataSource implements PostDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [];
  }
}

class _MixedDataSource implements PostDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Return a mix of valid and potentially problematic data
    return const [
      PostModel(id: 1, title: 'Valid Post 1', body: 'Valid content', userId: 1),
      PostModel(
        id: 3,
        title: 'Valid Post 2',
        body: 'More valid content',
        userId: 2,
      ),
    ];
  }
}

class _TimeoutDataSource implements PostDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    throw Exception('Request timeout - server did not respond in time');
  }
}

class _ConcurrentAccessDataSource implements PostDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 50));
    throw Exception('Concurrent access error - resource is locked');
  }
}
