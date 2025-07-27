import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/posts/domain/entities/post.dart';

void main() {
  group('Post Entity', () {
    const tPost = Post(
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
      userId: 1,
    );

    test('should be a subclass of Equatable', () {
      // assert
      expect(tPost, isA<Post>());
    });

    test('should have correct properties', () {
      // assert
      expect(tPost.id, equals(1));
      expect(tPost.title, equals('Test Title'));
      expect(tPost.body, equals('Test Body'));
      expect(tPost.userId, equals(1));
    });

    test('should support equality comparison', () {
      // arrange
      const tPost1 = Post(
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
        userId: 1,
      );

      const tPost2 = Post(
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
        userId: 1,
      );

      const tPost3 = Post(
        id: 2,
        title: 'Different Title',
        body: 'Different Body',
        userId: 2,
      );

      // assert
      expect(tPost1, equals(tPost2));
      expect(tPost1, isNot(equals(tPost3)));
    });

    test('should have proper props for equality', () {
      // assert
      expect(tPost.props, equals([1, 'Test Title', 'Test Body', 1]));
    });
  });
}
