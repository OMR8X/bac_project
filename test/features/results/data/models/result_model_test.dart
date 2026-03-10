import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/models/result_model.dart';
import 'package:neuro_app/features/results/domain/entities/result.dart';
import 'package:neuro_app/features/results/domain/entities/result_test_mode.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tResultModel = ResultsTestFixtures.tResultModel;
  final tResultJson = ResultsTestFixtures.tResultJson;

  test('should be a subclass of Result entity', () {
    // Assert
    expect(tResultModel, isA<Result>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () {
      // Act
      final result = ResultModel.fromJson(tResultJson);
      expect(result.props, tResultModel.props);
    });

    test('should parse is_test_mode false correctly as exploring', () {
      // Arrange
      final json = Map<String, dynamic>.from(tResultJson);
      json['is_test_mode'] = false;

      // Act
      final result = ResultModel.fromJson(json);

      // Assert
      expect(result.resultTestMode, ResultTestMode.exploring);
    });

    test('should parse missing question_answers as an empty list', () {
      // Arrange
      final json = Map<String, dynamic>.from(tResultJson);
      json.remove('question_answers'); // Missing key

      // Act
      final result = ResultModel.fromJson(json);

      // Assert
      expect(result.questionAnswers, isEmpty);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final resultJson = tResultModel.toJson();

      // Assert
      // Check specific complex fields
      expect(resultJson['is_test_mode'], true);
      expect(resultJson['user_id'], 'user-123');
      expect((resultJson['question_answers'] as List).length, 1);
    });
  });

  group('copyWith', () {
    test('should return a cloned instance with updated fields', () {
      // Act
      final updatedModel = tResultModel.copyWith(
        score: 99.0,
        resultTestMode: ResultTestMode.exploring,
      );

      // Assert
      expect(updatedModel.score, 99.0);
      expect(updatedModel.resultTestMode, ResultTestMode.exploring);

      // Other fields should remain unchanged
      expect(updatedModel.id, tResultModel.id);
      expect(updatedModel.totalQuestions, tResultModel.totalQuestions);
    });
  });
}
