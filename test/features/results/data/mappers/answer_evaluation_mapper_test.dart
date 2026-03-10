import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/mappers/answer_evaluation_mapper.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tAnswerEvaluationModel = ResultsTestFixtures.tAnswerEvaluationModel;

  group('AnswerEvaluationModelExtension (toEntity)', () {
    test('should map AnswerEvaluationModel to AnswerEvaluation entity', () {
      // Act
      final result = tAnswerEvaluationModel.toEntity;

      // Assert
      expect(result.props, equals(tAnswerEvaluationModel.props));
    });
  });

  group('AnswerEvaluationEntityExtension (toModel)', () {
    test('should map AnswerEvaluation entity to AnswerEvaluationModel', () {
      // Act
      final result = tAnswerEvaluationModel.toEntity.toModel;

      // Assert
      expect(result, equals(tAnswerEvaluationModel));
    });
  });

  group('Round Trip', () {
    test('model -> entity -> model should produce identical model', () {
      // Act
      final roundTripModel = tAnswerEvaluationModel.toEntity.toModel;

      // Assert
      expect(roundTripModel, equals(tAnswerEvaluationModel));
    });
  });
}
