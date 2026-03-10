import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/responses/get_result_leaderboard_response.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  group('GetResultLeaderboardResponse', () {
    test('should parse correctly from valid JSON', () {
      // Act
      final response = GetResultLeaderboardResponse.fromJson(
        ResultsTestFixtures.tGetResultLeaderboardResponseJson,
      );

      // Assert
      expect(response.topResults, isNotEmpty);
      expect(response.topResults.first.props, ResultsTestFixtures.tResultModel.props);
    });

    test('should return empty list when results key is missing', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final response = GetResultLeaderboardResponse.fromJson(json);

      // Assert
      expect(response.topResults, isEmpty);
    });
  });
}
