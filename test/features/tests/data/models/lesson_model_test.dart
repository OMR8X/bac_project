import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/lesson_model.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';

void main() {
  group('LessonModel', () {
    late LessonModel lessonModel;

    setUp(() {
      lessonModel = const LessonModel(id: 1, title: 'Lesson 1', unitId: 1, questionsCount: 10);
    });

    group('fromJson', () {
      test('should create LessonModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'title': 'Lesson 1', 'unit_id': 1, 'questions_count': 10};

        // Act
        final result = LessonModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Lesson 1'));
        expect(result.unitId, equals(1));
        expect(result.questionsCount, equals(10));
      });

      test('should create LessonModel with different values', () {
        // Arrange
        final json = {'id': 2, 'title': 'Advanced Lesson', 'unit_id': 2, 'questions_count': 15};

        // Act
        final result = LessonModel.fromJson(json);

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Advanced Lesson'));
        expect(result.unitId, equals(2));
        expect(result.questionsCount, equals(15));
      });
    });

    group('toJson', () {
      test('should convert LessonModel to JSON', () {
        // Act
        final result = lessonModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['title'], equals('Lesson 1'));
        expect(result['unit_id'], equals(1));
        expect(result['questions_count'], equals(10));
      });

      test('should convert different LessonModel to JSON', () {
        // Arrange
        const model = LessonModel(id: 5, title: 'Test Lesson', unitId: 3, questionsCount: 20);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(5));
        expect(result['title'], equals('Test Lesson'));
        expect(result['unit_id'], equals(3));
        expect(result['questions_count'], equals(20));
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = lessonModel.copyWith(title: 'Updated Lesson 1', questionsCount: 15);

        // Assert
        expect(result.id, equals(lessonModel.id));
        expect(result.title, equals('Updated Lesson 1'));
        expect(result.unitId, equals(lessonModel.unitId));
        expect(result.questionsCount, equals(15));
      });

      test('should create copy with all fields updated', () {
        // Act
        final result = lessonModel.copyWith(
          id: 2,
          title: 'New Lesson',
          unitId: 2,
          questionsCount: 25,
        );

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('New Lesson'));
        expect(result.unitId, equals(2));
        expect(result.questionsCount, equals(25));
      });

      test('should create copy with no changes when no parameters provided', () {
        // Act
        final result = lessonModel.copyWith();

        // Assert
        expect(result.id, equals(lessonModel.id));
        expect(result.title, equals(lessonModel.title));
        expect(result.unitId, equals(lessonModel.unitId));
        expect(result.questionsCount, equals(lessonModel.questionsCount));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const other = LessonModel(id: 1, title: 'Lesson 1', unitId: 1, questionsCount: 10);

        // Assert
        expect(lessonModel, equals(other));
        expect(lessonModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        const other = LessonModel(id: 2, title: 'Lesson 1', unitId: 1, questionsCount: 10);

        // Assert
        expect(lessonModel, isNot(equals(other)));
      });

      test('should not be equal when title differs', () {
        // Arrange
        const other = LessonModel(id: 1, title: 'Different Lesson', unitId: 1, questionsCount: 10);

        // Assert
        expect(lessonModel, isNot(equals(other)));
      });

      test('should not be equal when unitId differs', () {
        // Arrange
        const other = LessonModel(id: 1, title: 'Lesson 1', unitId: 2, questionsCount: 10);

        // Assert
        expect(lessonModel, isNot(equals(other)));
      });

      test('should not be equal when questionsCount differs', () {
        // Arrange
        const other = LessonModel(id: 1, title: 'Lesson 1', unitId: 1, questionsCount: 15);

        // Assert
        expect(lessonModel, isNot(equals(other)));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = lessonModel.toString();

        // Assert
        expect(result, contains('LessonModel'));
        expect(result, contains('id: 1'));
        expect(result, contains('title: Lesson 1'));
        expect(result, contains('unitId: 1'));
        expect(result, contains('questionsCount: 10'));
      });
    });

    group('inheritance', () {
      test('should be instance of Lesson', () {
        // Assert
        expect(lessonModel, isA<Lesson>());
      });
    });
  });
}
