import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

void main() {
  group('QuestionCategoryModel', () {
    late QuestionCategoryModel questionCategoryModel;

    setUp(() {
      questionCategoryModel = const QuestionCategoryModel(
        id: 1,
        title: 'Mathematics',
        questionsCount: 50,
      );
    });

    group('fromJson', () {
      test('should create QuestionCategoryModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'title': 'Mathematics', 'questions_count': 50};

        // Act
        final result = QuestionCategoryModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Mathematics'));
        expect(result.questionsCount, equals(50));
      });

      test('should create QuestionCategoryModel with different values', () {
        // Arrange
        final json = {'id': 2, 'title': 'Science', 'questions_count': 75};

        // Act
        final result = QuestionCategoryModel.fromJson(json);

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Science'));
        expect(result.questionsCount, equals(75));
      });

      test('should handle zero questions count', () {
        // Arrange
        final json = {'id': 3, 'title': 'Empty Category', 'questions_count': 0};

        // Act
        final result = QuestionCategoryModel.fromJson(json);

        // Assert
        expect(result.id, equals(3));
        expect(result.title, equals('Empty Category'));
        expect(result.questionsCount, equals(0));
      });
    });

    group('toJson', () {
      test('should convert QuestionCategoryModel to JSON', () {
        // Act
        final result = questionCategoryModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['title'], equals('Mathematics'));
        expect(result['questions_count'], equals(50));
      });

      test('should convert different QuestionCategoryModel to JSON', () {
        // Arrange
        const model = QuestionCategoryModel(id: 5, title: 'History', questionsCount: 100);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(5));
        expect(result['title'], equals('History'));
        expect(result['questions_count'], equals(100));
      });
    });

    group('inheritance', () {
      test('should be instance of QuestionCategory', () {
        // Assert
        expect(questionCategoryModel, isA<QuestionCategory>());
      });
    });
  });
}
