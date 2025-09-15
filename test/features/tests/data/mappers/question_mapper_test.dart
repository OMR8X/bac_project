import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:bac_project/features/tests/data/mappers/question_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';

void main() {
  group('QuestionMapper', () {
    late QuestionModel questionModel;
    late Question questionEntity;
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

      questionEntity = Question(
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

    group('QuestionModelExtension.toEntity', () {
      test('should convert QuestionModel to Question entity', () {
        // Act
        final result = questionModel.toEntity();

        // Assert
        expect(result, isA<Question>());
        expect(result.id, equals(questionModel.id));
        expect(result.content, equals(questionModel.content));
        expect(result.options, equals(questionModel.options));
        expect(result.unitId, equals(questionModel.unitId));
        expect(result.lessonId, equals(questionModel.lessonId));
        expect(result.imageUrl, equals(questionModel.imageUrl));
        expect(result.categoryId, equals(questionModel.categoryId));
        expect(result.isMCQ, equals(questionModel.isMCQ));
        expect(result.explain, equals(questionModel.explain));
      });

      test('should handle null optional fields', () {
        // Arrange
        final model = QuestionModel(id: 1, content: 'Test question', options: [], lessonId: 1);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('Test question'));
        expect(result.options, isEmpty);
        expect(result.unitId, isNull);
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, isNull);
        expect(result.categoryId, isNull);
        expect(result.isMCQ, isNull);
        expect(result.explain, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = questionModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('What is the capital of France?'));
        expect(result.options.length, equals(3));
        expect(result.unitId, equals(1));
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, equals('https://example.com/image.jpg'));
        expect(result.categoryId, equals(1));
        expect(result.isMCQ, equals(true));
        expect(result.explain, equals('Paris is the capital of France.'));
      });
    });

    group('QuestionEntityExtension.toModel', () {
      test('should convert Question entity to QuestionModel', () {
        // Act
        final result = questionEntity.toModel();

        // Assert
        expect(result, isA<QuestionModel>());
        expect(result.id, equals(questionEntity.id));
        expect(result.content, equals(questionEntity.content));
        expect(result.options, equals(questionEntity.options));
        expect(result.unitId, equals(questionEntity.unitId));
        expect(result.lessonId, equals(questionEntity.lessonId));
        expect(result.imageUrl, equals(questionEntity.imageUrl));
        expect(result.categoryId, equals(questionEntity.categoryId));
        expect(result.isMCQ, equals(questionEntity.isMCQ));
        expect(result.explain, equals(questionEntity.explain));
      });

      test('should handle null optional fields', () {
        // Arrange
        const entity = Question(id: 1, content: 'Test question', options: [], lessonId: 1);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('Test question'));
        expect(result.options, isEmpty);
        expect(result.unitId, isNull);
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, isNull);
        expect(result.categoryId, isNull);
        expect(result.isMCQ, isNull);
        expect(result.explain, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = questionEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.content, equals('What is the capital of France?'));
        expect(result.options.length, equals(3));
        expect(result.unitId, equals(1));
        expect(result.lessonId, equals(1));
        expect(result.imageUrl, equals('https://example.com/image.jpg'));
        expect(result.categoryId, equals(1));
        expect(result.isMCQ, equals(true));
        expect(result.explain, equals('Paris is the capital of France.'));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = questionModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(questionModel.id));
        expect(backToModel.content, equals(questionModel.content));
        expect(backToModel.options, equals(questionModel.options));
        expect(backToModel.unitId, equals(questionModel.unitId));
        expect(backToModel.lessonId, equals(questionModel.lessonId));
        expect(backToModel.imageUrl, equals(questionModel.imageUrl));
        expect(backToModel.categoryId, equals(questionModel.categoryId));
        expect(backToModel.isMCQ, equals(questionModel.isMCQ));
        expect(backToModel.explain, equals(questionModel.explain));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = questionEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(questionEntity.id));
        expect(backToEntity.content, equals(questionEntity.content));
        expect(backToEntity.options, equals(questionEntity.options));
        expect(backToEntity.unitId, equals(questionEntity.unitId));
        expect(backToEntity.lessonId, equals(questionEntity.lessonId));
        expect(backToEntity.imageUrl, equals(questionEntity.imageUrl));
        expect(backToEntity.categoryId, equals(questionEntity.categoryId));
        expect(backToEntity.isMCQ, equals(questionEntity.isMCQ));
        expect(backToEntity.explain, equals(questionEntity.explain));
      });
    });
  });
}
