import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/test_options_model.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

void main() {
  group('TestOptionsModel', () {
    late TestOptionsModel testOptionsModel;

    setUp(() {
      testOptionsModel = const TestOptionsModel(
        selectedMode: TestMode.testing,
        selectedCategories: [
          QuestionCategory(id: 1, title: 'Math', questionsCount: 50),
          QuestionCategory(id: 2, title: 'Science', questionsCount: 75),
          QuestionCategory(id: 3, title: 'History', questionsCount: 25),
        ],
        selectedQuestionsCount: 20,
        selectedUnitsIDs: [1, 2],
        selectedLessonsIDs: [1, 2, 3, 4],
        categories: [
          QuestionCategory(id: 1, title: 'Math', questionsCount: 50),
          QuestionCategory(id: 2, title: 'Science', questionsCount: 75),
          QuestionCategory(id: 3, title: 'History', questionsCount: 25),
        ],
        enableSounds: true,
        showTrueAnswers: false,
      );
    });

    group('fromJson', () {
      test('should create TestOptionsModel from valid JSON', () {
        // Arrange
        final json = {
          'selected_mode': 'testing',
          'selected_categories': [
            {'id': 1, 'title': 'Math', 'questions_count': 50},
            {'id': 2, 'title': 'Science', 'questions_count': 75},
            {'id': 3, 'title': 'History', 'questions_count': 25},
          ],
          'selected_questions_count': 20,
          'selected_units_ids': [1, 2],
          'selected_lessons_ids': [1, 2, 3, 4],
          'categories': [
            {'id': 1, 'title': 'Math', 'questions_count': 50},
            {'id': 2, 'title': 'Science', 'questions_count': 75},
            {'id': 3, 'title': 'History', 'questions_count': 25},
          ],
          'enable_sounds': true,
          'show_true_answers': false,
        };

        // Act
        final result = TestOptionsModel.fromJson(json);

        // Assert
        expect(result.selectedMode, equals(TestMode.testing));
        expect(result.selectedCategories, isA<List>());
        expect(result.selectedQuestionsCount, equals(20));
        expect(result.selectedUnitsIDs, equals([1, 2]));
        expect(result.selectedLessonsIDs, equals([1, 2, 3, 4]));
        expect(result.categories, isA<List>());
        expect(result.enableSounds, equals(true));
        expect(result.showTrueAnswers, equals(false));
      });

      test('should create TestOptionsModel with different values', () {
        // Arrange
        final json = {
          'selected_mode': 'exploring',
          'selected_categories': [
            {'id': 4, 'title': 'Physics', 'questions_count': 60},
            {'id': 5, 'title': 'Chemistry', 'questions_count': 40},
          ],
          'selected_questions_count': 50,
          'selected_units_ids': [3, 4, 5],
          'selected_lessons_ids': [5, 6],
          'categories': [
            {'id': 4, 'title': 'Physics', 'questions_count': 60},
            {'id': 5, 'title': 'Chemistry', 'questions_count': 40},
          ],
          'enable_sounds': false,
          'show_true_answers': true,
        };

        // Act
        final result = TestOptionsModel.fromJson(json);

        // Assert
        expect(result.selectedMode, equals(TestMode.exploring));
        expect(result.selectedCategories, isA<List>());
        expect(result.selectedQuestionsCount, equals(50));
        expect(result.selectedUnitsIDs, equals([3, 4, 5]));
        expect(result.selectedLessonsIDs, equals([5, 6]));
        expect(result.categories, isA<List>());
        expect(result.enableSounds, equals(false));
        expect(result.showTrueAnswers, equals(true));
      });

      test('should handle empty lists', () {
        // Arrange
        final json = {
          'selected_mode': 'testing',
          'selected_categories': [],
          'selected_questions_count': 10,
          'selected_units_ids': [],
          'selected_lessons_ids': [],
          'categories': [],
          'enable_sounds': true,
          'show_true_answers': false,
        };

        // Act
        final result = TestOptionsModel.fromJson(json);

        // Assert
        expect(result.selectedCategories, isEmpty);
        expect(result.selectedUnitsIDs, isEmpty);
        expect(result.selectedLessonsIDs, isEmpty);
        expect(result.categories, isEmpty);
      });
    });

    group('toJson', () {
      test('should convert TestOptionsModel to JSON', () {
        // Act
        final result = testOptionsModel.toJson();

        // Assert
        expect(result['selected_mode'], equals('testing'));
        expect(result['selected_categories'], isA<List>());
        expect(result['selected_questions_count'], equals(20));
        expect(result['selected_units_ids'], equals([1, 2]));
        expect(result['selected_lessons_ids'], equals([1, 2, 3, 4]));
        expect(result['categories'], isA<List>());
        expect(result['enable_sounds'], equals(true));
        expect(result['show_true_answers'], equals(false));
      });

      test('should convert different TestOptionsModel to JSON', () {
        // Arrange
        const model = TestOptionsModel(
          selectedMode: TestMode.exploring,
          selectedCategories: [QuestionCategory(id: 1, title: 'Math', questionsCount: 50)],
          selectedQuestionsCount: 30,
          selectedUnitsIDs: [1],
          selectedLessonsIDs: [1, 2],
          categories: [QuestionCategory(id: 1, title: 'Math', questionsCount: 50)],
          enableSounds: false,
          showTrueAnswers: true,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['selected_mode'], equals('exploring'));
        expect(result['selected_categories'], isA<List>());
        expect(result['selected_questions_count'], equals(30));
        expect(result['selected_units_ids'], equals([1]));
        expect(result['selected_lessons_ids'], equals([1, 2]));
        expect(result['categories'], isA<List>());
        expect(result['enable_sounds'], equals(false));
        expect(result['show_true_answers'], equals(true));
      });
    });

    group('inheritance', () {
      test('should be instance of TestOptions', () {
        // Assert
        expect(testOptionsModel, isA<TestOptions>());
      });
    });
  });
}
