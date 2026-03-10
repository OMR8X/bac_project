import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/add_result_response.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('AddResultResponse', () {
    test('should parse correctly from valid JSON', () {
      // Act
      final response = AddResultResponse.fromJson(ResultsTestFixtures.tResultJson);

      // Assert
      expect(response.result.props, ResultsTestFixtures.tResultModel.props);
    });

    test('should throw Failure on malformed JSON due to errorToFailure catch block', () {
      // Arrange
      final json = <String, dynamic>{'bad_key': 'no_data'};

      // Act & Assert
      // Expected to throw a Failure because the parsing will throw a TypeError which
      // errorToFailure catches and turns into an UnknownFailure or similar.
      expect(() => AddResultResponse.fromJson(json), throwsA(isA<Failure>()));
    });
  });
}
