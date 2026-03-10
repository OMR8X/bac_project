import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/results/data/mappers/result_mapper.dart';
import 'package:neuro_app/features/results/domain/entities/result.dart';
import '../../helpers/results_test_fixtures.dart';

void main() {
  final tResultModel = ResultsTestFixtures.tResultModel;
  final tResultEntity = tResultModel as Result; // Model is a subclass of Entity

  group('ResultModelExtension (toEntity)', () {
    test('should map ResultModel to Result entity with correct fields', () {
      // Act
      final result = tResultModel.toEntity;

      // Assert
      expect(result.props, equals(tResultModel.props));
    });
  });

  group('ResultEntityExtension (toModel)', () {
    test('should map Result entity to ResultModel with correct fields', () {
      // Act
      final result = tResultEntity.toModel;

      // Assert
      expect(result, equals(tResultModel));
    });
  });

  group('Round Trip', () {
    test('model -> entity -> model should produce identical model', () {
      // Act
      final roundTripModel = tResultModel.toEntity.toModel;

      // Assert
      expect(roundTripModel, equals(tResultModel));
    });
  });
}
