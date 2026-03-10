import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/mappers/result_answer_mapper.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tResultAnswerModel = ResultsTestFixtures.tResultAnswerModel;

  group('ResultAnswerModelExtension (toEntity)', () {
    test('should map ResultAnswerModel to ResultAnswer entity', () {
      // Act
      final result = tResultAnswerModel.toEntity;

      // Assert
      expect(result.props, equals(tResultAnswerModel.props));
    });
  });

  group('ResultAnswerEntityExtension (toModel)', () {
    test('should map ResultAnswer entity to ResultAnswerModel', () {
      // Act
      final result = tResultAnswerModel.toEntity.toModel;

      // Assert
      expect(result, equals(tResultAnswerModel));
    });
  });

  group('Round Trip', () {
    test('model -> entity -> model should produce equivalent model', () {
      // Act
      final roundTripModel = tResultAnswerModel.toEntity.toModel;

      // Assert
      expect(roundTripModel, equals(tResultAnswerModel));
    });
  });
}
