import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/result_answer_model.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';

void main() {
  group('ResultAnswerModel', () {
    late ResultAnswerModel resultAnswerModel;

    setUp(() {
      resultAnswerModel = const ResultAnswerModel(id: 1, resultId: 1, questionId: 1, optionId: 1);
    });

    group('fromJson', () {
      test('should create ResultAnswerModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'result_id': 1, 'question_id': 1, 'option_id': 1};

        // Act
        final result = ResultAnswerModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, equals(1));
      });

      test('should create ResultAnswerModel with null optionId', () {
        // Arrange
        final json = {'id': 1, 'result_id': 1, 'question_id': 1, 'option_id': null};

        // Act
        final result = ResultAnswerModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, isNull);
      });
    });

    group('toJson', () {
      test('should convert ResultAnswerModel to JSON', () {
        // Act
        final result = resultAnswerModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['result_id'], equals(1));
        expect(result['question_id'], equals(1));
        expect(result['option_id'], equals(1));
      });

      test('should handle null optionId in JSON', () {
        // Arrange
        const model = ResultAnswerModel(id: 1, resultId: 1, questionId: 1, optionId: null);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['option_id'], isNull);
      });
    });

    group('inheritance', () {
      test('should be instance of ResultAnswer', () {
        // Assert
        expect(resultAnswerModel, isA<ResultAnswer>());
      });
    });
  });
}
