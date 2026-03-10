import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/get_answer_evaluations_response.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('GetAnswerEvaluationsResponse', () {
    test('should parse correctly from valid JSON', () {
      // Act
      final response = GetAnswerEvaluationsResponse.fromJson(
        ResultsTestFixtures.tGetAnswerEvaluationsResponseJson,
      );

      // Assert
      expect(response.answerEvaluations, isNotEmpty);
      expect(
        response.answerEvaluations.first.props,
        ResultsTestFixtures.tAnswerEvaluationModel.props,
      );
    });

    test('should throw an error (or TypeError) when answers_evaluations is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act & Assert
      // The implementation does not wrap this list mapping in a try-catch,
      // so we expect it to throw a TypeError or NoSuchMethodError
      expect(() => GetAnswerEvaluationsResponse.fromJson(json), throwsA(anything));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final response1 = GetAnswerEvaluationsResponse(
        answerEvaluations: [ResultsTestFixtures.tAnswerEvaluationModel],
      );

      // Act
      final response2 = response1.copyWith(answerEvaluations: []);

      // Assert
      expect(response2.answerEvaluations, isEmpty);
      expect(response1.answerEvaluations, isNotEmpty);
    });
  });
}
