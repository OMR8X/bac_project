import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/models/result_answer_model.dart';
import 'package:neuro_app/features/results/domain/entities/result_answer.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tResultAnswerModel = ResultsTestFixtures.tResultAnswerModel;
  final tResultAnswerJson = ResultsTestFixtures.tResultAnswerJson;

  test('should be a subclass of ResultAnswer entity', () {
    // Assert
    expect(tResultAnswerModel, isA<ResultAnswer>());
  });

  group('fromJson', () {
    test('should return a valid model when JSON is correct', () {
      // Act
      final result = ResultAnswerModel.fromJson(tResultAnswerJson);
      // Assert
      expect(result, equals(tResultAnswerModel));
    });
  });

  group('toJson', () {
    test('should return a correct JSON map', () {
      // Act
      final resultJson = tResultAnswerModel.toJson();

      // Assert
      expect(resultJson['id'], 1);
      expect(resultJson['result_id'], 1);
      expect(resultJson['question_id'], 201);
      expect(resultJson['option_id'], 301);
    });
  });
}
