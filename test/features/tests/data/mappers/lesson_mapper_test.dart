import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/lesson_model.dart';
import 'package:bac_project/features/tests/data/mappers/lesson_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';

void main() {
  group('LessonMapper', () {
    late LessonModel lessonModel;
    late Lesson lessonEntity;

    setUp(() {
      lessonModel = const LessonModel(id: 1, title: 'Lesson 1', unitId: 1, questionsCount: 10);

      lessonEntity = const Lesson(id: 1, title: 'Lesson 1', unitId: 1, questionsCount: 10);
    });

    group('LessonModelExtension.toEntity', () {
      test('should convert LessonModel to Lesson entity', () {
        // Act
        final result = lessonModel.toEntity();

        // Assert
        expect(result, isA<Lesson>());
        expect(result.id, equals(lessonModel.id));
        expect(result.title, equals(lessonModel.title));
        expect(result.unitId, equals(lessonModel.unitId));
        expect(result.questionsCount, equals(lessonModel.questionsCount));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = lessonModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Lesson 1'));
        expect(result.unitId, equals(1));
        expect(result.questionsCount, equals(10));
      });

      test('should handle different values', () {
        // Arrange
        const model = LessonModel(id: 5, title: 'Advanced Lesson', unitId: 2, questionsCount: 25);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Advanced Lesson'));
        expect(result.unitId, equals(2));
        expect(result.questionsCount, equals(25));
      });

      test('should handle zero values', () {
        // Arrange
        const model = LessonModel(id: 0, title: '', unitId: 0, questionsCount: 0);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(0));
        expect(result.title, equals(''));
        expect(result.unitId, equals(0));
        expect(result.questionsCount, equals(0));
      });
    });

    group('LessonEntityExtension.toModel', () {
      test('should convert Lesson entity to LessonModel', () {
        // Act
        final result = lessonEntity.toModel();

        // Assert
        expect(result, isA<LessonModel>());
        expect(result.id, equals(lessonEntity.id));
        expect(result.title, equals(lessonEntity.title));
        expect(result.unitId, equals(lessonEntity.unitId));
        expect(result.questionsCount, equals(lessonEntity.questionsCount));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = lessonEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Lesson 1'));
        expect(result.unitId, equals(1));
        expect(result.questionsCount, equals(10));
      });

      test('should handle different values', () {
        // Arrange
        const entity = Lesson(id: 5, title: 'Advanced Lesson', unitId: 2, questionsCount: 25);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Advanced Lesson'));
        expect(result.unitId, equals(2));
        expect(result.questionsCount, equals(25));
      });

      test('should handle zero values', () {
        // Arrange
        const entity = Lesson(id: 0, title: '', unitId: 0, questionsCount: 0);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(0));
        expect(result.title, equals(''));
        expect(result.unitId, equals(0));
        expect(result.questionsCount, equals(0));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = lessonModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(lessonModel.id));
        expect(backToModel.title, equals(lessonModel.title));
        expect(backToModel.unitId, equals(lessonModel.unitId));
        expect(backToModel.questionsCount, equals(lessonModel.questionsCount));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = lessonEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(lessonEntity.id));
        expect(backToEntity.title, equals(lessonEntity.title));
        expect(backToEntity.unitId, equals(lessonEntity.unitId));
        expect(backToEntity.questionsCount, equals(lessonEntity.questionsCount));
      });

      test('should handle different values in round-trip conversion', () {
        // Arrange
        const model = LessonModel(id: 10, title: 'Test Lesson', unitId: 5, questionsCount: 50);

        // Act
        final entity = model.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(10));
        expect(backToModel.title, equals('Test Lesson'));
        expect(backToModel.unitId, equals(5));
        expect(backToModel.questionsCount, equals(50));
      });
    });
  });
}
