import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/get_result_questions_details_response.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('GetResultQuestionsDetailsResponse', () {
    test('should parse correctly from valid JSON', () {
      // Act
      final response = GetResultQuestionsDetailsResponse.fromJson(
        ResultsTestFixtures.tGetResultQuestionsDetailsResponseJson,
      );

      // Assert
      expect(response.resultQuestions, isNotEmpty);
      expect(response.resultQuestions.first.props, ResultsTestFixtures.tQuestionModel.props);
    });

    test('should parse returning empty list when questions key is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final response = GetResultQuestionsDetailsResponse.fromJson(json);

      // Assert
      expect(response.resultQuestions, isEmpty);
    });

    test('should throw Failure on malformed inner data', () {
      // Arrange
      final json = {
        'questions': [
          {'malformed': 'data'},
        ],
      };

      // Act & Assert
      expect(() => GetResultQuestionsDetailsResponse.fromJson(json), throwsA(isA<Failure>()));
    });
  });
}
