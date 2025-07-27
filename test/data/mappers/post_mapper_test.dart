import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/posts/domain/entities/post.dart';
import 'package:bac_project/features/posts/data/models/post_model.dart';
import 'package:bac_project/features/posts/data/mappers/post_mapper.dart';

void main() {
  group('PostMapper', () {
    const testPostModel = PostModel(
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
      userId: 1,
    );

    const testPost = Post(
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
      userId: 1,
    );

    test('should convert PostModel to Post entity', () {
      // Act
      final result = testPostModel.toEntity();

      // Assert
      expect(result, equals(testPost));
      expect(result.id, equals(testPostModel.id));
      expect(result.title, equals(testPostModel.title));
      expect(result.body, equals(testPostModel.body));
      expect(result.userId, equals(testPostModel.userId));
    });

    test('should convert Post entity to PostModel', () {
      // Act
      final result = testPost.toModel();

      // Assert
      expect(result, equals(testPostModel));
      expect(result.id, equals(testPost.id));
      expect(result.title, equals(testPost.title));
      expect(result.body, equals(testPost.body));
      expect(result.userId, equals(testPost.userId));
    });

    test('should maintain data integrity during round-trip conversion', () {
      // Act
      final postFromModel = testPostModel.toEntity();
      final modelFromPost = postFromModel.toModel();

      // Assert
      expect(modelFromPost, equals(testPostModel));
    });
  });
}
