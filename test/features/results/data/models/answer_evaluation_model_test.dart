import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/models/answer_evaluation_model.dart';
import 'package:neuro_app/features/results/domain/entities/answer_evaluation.dart';
import 'package:neuro_app/features/results/data/mappers/answer_evaluation_mapper.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tAnswerEvaluationModel = ResultsTestFixtures.tAnswerEvaluationModel;
  final tAnswerEvaluationJson = ResultsTestFixtures.tAnswerEvaluationJson;

  test('should be a subclass of AnswerEvaluation entity', () {
    // Assert
    expect(tAnswerEvaluationModel, isA<AnswerEvaluation>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () {
      // Act
      final result = AnswerEvaluationModel.fromJson(tAnswerEvaluationJson);
      // Assert
      expect(result.props, tAnswerEvaluationModel.props);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final resultJson = tAnswerEvaluationModel.toJson();

      // Assert
      expect(resultJson['is_correct'], true);
      expect(resultJson['model_name'], 'gpt-4');
      expect(resultJson['confidence'], 0.95);
    });
  });

  group('toEntity', () {
    test('should return the correct base entity', () {
      // Act
      final entity = tAnswerEvaluationModel.toEntity;

      expect(entity.props, tAnswerEvaluationModel.props);
    });
  });

  group('copyWith', () {
    test('should return a cloned instance with updated fields', () {
      // Act
      final updatedModel = tAnswerEvaluationModel.copyWith(
        isCorrect: false,
        confidence: 0.1,
      );

      // Assert
      expect(updatedModel.isCorrect, false);
      expect(updatedModel.confidence, 0.1);

      // Other fields remain unchanged
      expect(updatedModel.id, tAnswerEvaluationModel.id);
      expect(updatedModel.notes, tAnswerEvaluationModel.notes);
    });
  });
}
