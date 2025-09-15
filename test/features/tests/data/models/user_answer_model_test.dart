import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/user_answer_model.dart';
import 'package:bac_project/features/tests/domain/entities/user_answer.dart';

void main() {
  group('UserAnswerModel', () {
    late UserAnswerModel userAnswerModel;

    setUp(() {
      userAnswerModel = const UserAnswerModel(questionId: 1, selectedOptionId: 1);
    });

    group('fromJson', () {
      test('should create UserAnswerModel from valid JSON', () {
        // Arrange
        final json = {'question_id': 1, 'selected_option_id': 1};

        // Act
        final result = UserAnswerModel.fromJson(json);

        // Assert
        expect(result.questionId, equals(1));
        expect(result.selectedOptionId, equals(1));
      });

      test('should create UserAnswerModel with null selectedOptionId', () {
        // Arrange
        final json = {'question_id': 1, 'selected_option_id': null};

        // Act
        final result = UserAnswerModel.fromJson(json);

        // Assert
        expect(result.questionId, equals(1));
        expect(result.selectedOptionId, isNull);
      });

      test('should create UserAnswerModel with different values', () {
        // Arrange
        final json = {'question_id': 5, 'selected_option_id': 3};

        // Act
        final result = UserAnswerModel.fromJson(json);

        // Assert
        expect(result.questionId, equals(5));
        expect(result.selectedOptionId, equals(3));
      });
    });

    group('toJson', () {
      test('should convert UserAnswerModel to JSON', () {
        // Act
        final result = userAnswerModel.toJson();

        // Assert
        expect(result['question_id'], equals(1));
        expect(result['selected_option_id'], equals(1));
      });

      test('should handle null selectedOptionId in JSON', () {
        // Arrange
        const model = UserAnswerModel(questionId: 1, selectedOptionId: null);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['question_id'], equals(1));
        expect(result['selected_option_id'], isNull);
      });

      test('should convert different UserAnswerModel to JSON', () {
        // Arrange
        const model = UserAnswerModel(questionId: 10, selectedOptionId: 5);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['question_id'], equals(10));
        expect(result['selected_option_id'], equals(5));
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = userAnswerModel.copyWith(selectedOptionId: 2);

        // Assert
        expect(result.questionId, equals(userAnswerModel.questionId));
        expect(result.selectedOptionId, equals(2));
      });

      test('should create copy with all fields updated', () {
        // Act
        final result = userAnswerModel.copyWith(questionId: 5, selectedOptionId: 3);

        // Assert
        expect(result.questionId, equals(5));
        expect(result.selectedOptionId, equals(3));
      });

      test('should create copy with no changes when no parameters provided', () {
        // Act
        final result = userAnswerModel.copyWith();

        // Assert
        expect(result.questionId, equals(userAnswerModel.questionId));
        expect(result.selectedOptionId, equals(userAnswerModel.selectedOptionId));
      });

      test('should create copy with different selectedOptionId', () {
        // Act
        final result = userAnswerModel.copyWith(selectedOptionId: 2);

        // Assert
        expect(result.questionId, equals(userAnswerModel.questionId));
        expect(result.selectedOptionId, equals(2));
      });
    });

    group('inheritance', () {
      test('should be instance of UserAnswer', () {
        // Assert
        expect(userAnswerModel, isA<UserAnswer>());
      });
    });
  });
}
