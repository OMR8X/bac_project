import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';

void main() {
  group('QuestionModel', () {
    late QuestionModel questionModel;
    late List<Option> testOptions;

    setUp(() {
      testOptions = [
        const Option(id: 1, questionId: 1, content: 'Option 1', isCorrect: true),
        const Option(id: 2, questionId: 1, content: 'Option 2', isCorrect: false),
        const Option(id: 3, questionId: 1, content: 'Option 3', isCorrect: false),
      ];

      questionModel = QuestionModel(
        id: 1,
        content: 'What is the capital of France?',
        options: testOptions,
        unitId: 1,
        lessonId: 1,
        imageUrl: 'https://example.com/image.jpg',
        categoryId: 1,
        isMCQ: true,
        explain: 'Paris is the capital of France.',
      );
    });

    group('fromJson', () {
      test('should create QuestionModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'content': 'What is the capital of France?',
          'options': [
            {'id': 1, 'question_id': 1, 'content': 'Option 1', 'is_correct': true},
            {'id': 2, 'question_id': 1, 'content': 'Option 2', 'is_correct': false},
          ],
          'unit_id': 1,
          'lesson_id': 1,
          'image': 'https://example.com/image.jpg',
          'category_id': 1,
          'is_mcq': true,
          'explain': 'Paris is the capital of France.',
        };

        // Act
        final result = QuestionModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('What is the capital of France?'));
        expect(result.options.length, equals(2));
        expect(result.unitId, equals(1));
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, equals('https://example.com/image.jpg'));
        expect(result.categoryId, equals(1));
        expect(result.isMCQ, equals(true));
        expect(result.explain, equals('Paris is the capital of France.'));
      });

      test('should create QuestionModel from JSON with null optional fields', () {
        // Arrange
        final json = {
          'id': 1,
          'content': 'What is the capital of France?',
          'options': [],
          'lesson_id': 1,
        };

        // Act
        final result = QuestionModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('What is the capital of France?'));
        expect(result.options, isEmpty);
        expect(result.unitId, isNull);
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, isNull);
        expect(result.categoryId, isNull);
        expect(result.isMCQ, isNull);
        expect(result.explain, isNull);
      });

      test('should handle q_url as imageUrl when image is null', () {
        // Arrange
        final json = {
          'id': 1,
          'content': 'What is the capital of France?',
          'options': [],
          'lesson_id': 1,
          'q_url': 'https://example.com/q_image.jpg',
        };

        // Act
        final result = QuestionModel.fromJson(json);

        // Assert
        expect(result.imageUrl, equals('https://example.com/q_image.jpg'));
      });

      test('should prioritize image over q_url', () {
        // Arrange
        final json = {
          'id': 1,
          'content': 'What is the capital of France?',
          'options': [],
          'lesson_id': 1,
          'image': 'https://example.com/image.jpg',
          'q_url': 'https://example.com/q_image.jpg',
        };

        // Act
        final result = QuestionModel.fromJson(json);

        // Assert
        expect(result.imageUrl, equals('https://example.com/image.jpg'));
      });
    });

    group('toJson', () {
      test('should convert QuestionModel to JSON', () {
        // Act
        final result = questionModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['content'], equals('What is the capital of France?'));
        expect(result['options'], isA<List>());
        expect(result['unit_id'], equals(1));
        expect(result['lesson_id'], equals(1));
        expect(result['image'], equals('https://example.com/image.jpg'));
        expect(result['category_id'], equals(1));
        expect(result['is_mcq'], equals(true));
        expect(result['explain'], equals('Paris is the capital of France.'));
      });

      test('should handle null optional fields in JSON', () {
        // Arrange
        final model = QuestionModel(id: 1, content: 'Test question', options: [], lessonId: 1);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['unit_id'], isNull);
        expect(result['image'], isNull);
        expect(result['category_id'], isNull);
        expect(result['is_mcq'], isNull);
        expect(result['explain'], isNull);
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = questionModel.copyWith(content: 'Updated question', isMCQ: false);

        // Assert
        expect(result.id, equals(questionModel.id));
        expect(result.content, equals('Updated question'));
        expect(result.options, equals(questionModel.options));
        expect(result.unitId, equals(questionModel.unitId));
        expect(result.lessonId, equals(questionModel.lessonId));
        expect(result.imageUrl, equals(questionModel.imageUrl));
        expect(result.categoryId, equals(questionModel.categoryId));
        expect(result.isMCQ, equals(false));
        expect(result.explain, equals(questionModel.explain));
      });

      test('should create copy with all fields updated', () {
        // Arrange
        final newOptions = [
          const Option(id: 4, questionId: 1, content: 'New Option 1', isCorrect: true),
        ];

        // Act
        final result = questionModel.copyWith(
          id: 2,
          content: 'New question',
          options: newOptions,
          unitId: 2,
          lessonId: 2,
          imageUrl: 'https://example.com/new_image.jpg',
          categoryId: 2,
          isMCQ: false,
          explain: 'New explanation',
        );

        // Assert
        expect(result.id, equals(2));
        expect(result.content, equals('New question'));
        expect(result.options, equals(newOptions));
        expect(result.unitId, equals(2));
        expect(result.lessonId, equals(2));
        expect(result.imageUrl, equals('https://example.com/new_image.jpg'));
        expect(result.categoryId, equals(2));
        expect(result.isMCQ, equals(false));
        expect(result.explain, equals('New explanation'));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final other = QuestionModel(
          id: 1,
          content: 'What is the capital of France?',
          options: testOptions,
          unitId: 1,
          lessonId: 1,
          imageUrl: 'https://example.com/image.jpg',
          categoryId: 1,
          isMCQ: true,
          explain: 'Paris is the capital of France.',
        );

        // Assert
        expect(questionModel, equals(other));
        expect(questionModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final other = QuestionModel(
          id: 2,
          content: 'What is the capital of France?',
          options: testOptions,
          unitId: 1,
          lessonId: 1,
          imageUrl: 'https://example.com/image.jpg',
          categoryId: 1,
          isMCQ: true,
          explain: 'Paris is the capital of France.',
        );

        // Assert
        expect(questionModel, isNot(equals(other)));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = questionModel.toString();

        // Assert
        expect(result, contains('QuestionModel'));
        expect(result, contains('id: 1'));
        expect(result, contains('content: What is the capital of France?'));
        expect(result, contains('lessonId: 1'));
      });
    });

    group('inheritance', () {
      test('should be instance of Question', () {
        // Assert
        expect(questionModel, isA<Question>());
      });
    });
  });
}
