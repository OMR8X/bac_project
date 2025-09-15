import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/data/mappers/question_category_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

void main() {
  group('QuestionCategoryMapper', () {
    late QuestionCategoryModel questionCategoryModel;
    late QuestionCategory questionCategoryEntity;

    setUp(() {
      questionCategoryModel = const QuestionCategoryModel(
        id: 1,
        title: 'Mathematics',
        questionsCount: 50,
      );

      questionCategoryEntity = const QuestionCategory(
        id: 1,
        title: 'Mathematics',
        questionsCount: 50,
      );
    });

    group('QuestionCategoryMapper.toModel', () {
      test('should convert QuestionCategory entity to QuestionCategoryModel', () {
        // Act
        final result = questionCategoryEntity.toModel;

        // Assert
        expect(result, isA<QuestionCategoryModel>());
        expect(result.id, equals(questionCategoryEntity.id));
        expect(result.title, equals(questionCategoryEntity.title));
        expect(result.questionsCount, equals(questionCategoryEntity.questionsCount));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = questionCategoryEntity.toModel;

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Mathematics'));
        expect(result.questionsCount, equals(50));
      });

      test('should handle different values', () {
        // Arrange
        const entity = QuestionCategory(id: 5, title: 'Science', questionsCount: 75);

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Science'));
        expect(result.questionsCount, equals(75));
      });

      test('should handle zero values', () {
        // Arrange
        const entity = QuestionCategory(id: 0, title: '', questionsCount: 0);

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(0));
        expect(result.title, equals(''));
        expect(result.questionsCount, equals(0));
      });
    });

    group('QuestionCategoryModelMapper.toEntity', () {
      test('should convert QuestionCategoryModel to QuestionCategory entity', () {
        // Act
        final result = questionCategoryModel.toEntity;

        // Assert
        expect(result, isA<QuestionCategory>());
        expect(result.id, equals(questionCategoryModel.id));
        expect(result.title, equals(questionCategoryModel.title));
        expect(result.questionsCount, equals(questionCategoryModel.questionsCount));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = questionCategoryModel.toEntity;

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Mathematics'));
        expect(result.questionsCount, equals(50));
      });

      test('should handle different values', () {
        // Arrange
        const model = QuestionCategoryModel(id: 5, title: 'Science', questionsCount: 75);

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Science'));
        expect(result.questionsCount, equals(75));
      });

      test('should handle zero values', () {
        // Arrange
        const model = QuestionCategoryModel(id: 0, title: '', questionsCount: 0);

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(0));
        expect(result.title, equals(''));
        expect(result.questionsCount, equals(0));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = questionCategoryModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals(questionCategoryModel.id));
        expect(backToModel.title, equals(questionCategoryModel.title));
        expect(backToModel.questionsCount, equals(questionCategoryModel.questionsCount));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = questionCategoryEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(questionCategoryEntity.id));
        expect(backToEntity.title, equals(questionCategoryEntity.title));
        expect(backToEntity.questionsCount, equals(questionCategoryEntity.questionsCount));
      });

      test('should handle different values in round-trip conversion', () {
        // Arrange
        const model = QuestionCategoryModel(id: 10, title: 'History', questionsCount: 100);

        // Act
        final entity = model.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals(10));
        expect(backToModel.title, equals('History'));
        expect(backToModel.questionsCount, equals(100));
      });
    });
  });
}
