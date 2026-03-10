import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/get_results_response.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('GetResultsResponse', () {
    test('should parse correctly from valid JSON', () {
      // Act
      final response = GetResultsResponse.fromJson(ResultsTestFixtures.tGetResultsResponseJson);

      // Assert
      expect(response.results, isNotEmpty);
      expect(response.results.first.props, ResultsTestFixtures.tResultModel.props);
    });

    test('should parse correctly from empty list JSON', () {
      // Arrange
      final json = {'results': []};

      // Act
      final response = GetResultsResponse.fromJson(json);

      // Assert
      expect(response.results, isEmpty);
    });

    test('should fail when JSON is malformed (missing key)', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act & Assert
      expect(() => GetResultsResponse.fromJson(json), throwsA(anything));
    });
  });
}
