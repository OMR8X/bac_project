import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/get_result_response.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('GetResultResponse', () {
    test('should parse correctly from valid JSON with previous results', () {
      // Act
      final response = GetResultResponse.fromJson(ResultsTestFixtures.tGetResultResponseJson);

      // Assert
      expect(response.result.props, ResultsTestFixtures.tResultModel.props);
      expect(response.previousResults, isNotNull);
      expect(response.previousResults!.length, 1);
      expect(response.previousResults!.first.props, ResultsTestFixtures.tResultModel.props);
    });

    test('should parse correctly when previous_results is missing (returns empty list)', () {
      // Arrange
      final json = {'result': ResultsTestFixtures.tResultJson};

      // Act
      final response = GetResultResponse.fromJson(json);

      // Assert
      expect(response.result.props, ResultsTestFixtures.tResultModel.props);
      expect(response.previousResults, isEmpty);
    });

    test('should throw Failure on malformed JSON', () {
      // Arrange
      final json = <String, dynamic>{'bad_key': 'no_data'};

      // Act & Assert
      expect(() => GetResultResponse.fromJson(json), throwsA(isA<Failure>()));
    });
  });
}
