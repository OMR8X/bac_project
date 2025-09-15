import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/result_answer_model.dart';
import 'package:bac_project/features/tests/data/mappers/result_answer_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';

void main() {
  group('ResultAnswerMapper', () {
    late ResultAnswerModel resultAnswerModel;
    late ResultAnswer resultAnswerEntity;

    setUp(() {
      resultAnswerModel = const ResultAnswerModel(id: 1, resultId: 1, questionId: 1, optionId: 1);

      resultAnswerEntity = const ResultAnswer(id: 1, resultId: 1, questionId: 1, optionId: 1);
    });

    group('ResultAnswerModelExtension.toEntity', () {
      test('should convert ResultAnswerModel to ResultAnswer entity', () {
        // Act
        final result = resultAnswerModel.toEntity();

        // Assert
        expect(result, isA<ResultAnswer>());
        expect(result.id, equals(resultAnswerModel.id));
        expect(result.resultId, equals(resultAnswerModel.resultId));
        expect(result.questionId, equals(resultAnswerModel.questionId));
        expect(result.optionId, equals(resultAnswerModel.optionId));
      });

      test('should handle null optionId field', () {
        // Arrange
        const model = ResultAnswerModel(id: 1, resultId: 1, questionId: 1, optionId: null);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = resultAnswerModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, equals(1));
      });

      test('should handle different values', () {
        // Arrange
        const model = ResultAnswerModel(id: 5, resultId: 10, questionId: 15, optionId: 20);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(5));
        expect(result.resultId, equals(10));
        expect(result.questionId, equals(15));
        expect(result.optionId, equals(20));
      });
    });

    group('ResultAnswerEntityExtension.toModel', () {
      test('should convert ResultAnswer entity to ResultAnswerModel', () {
        // Act
        final result = resultAnswerEntity.toModel();

        // Assert
        expect(result, isA<ResultAnswerModel>());
        expect(result.id, equals(resultAnswerEntity.id));
        expect(result.resultId, equals(resultAnswerEntity.resultId));
        expect(result.questionId, equals(resultAnswerEntity.questionId));
        expect(result.optionId, equals(resultAnswerEntity.optionId));
      });

      test('should handle null optionId field', () {
        // Arrange
        const entity = ResultAnswer(id: 1, resultId: 1, questionId: 1, optionId: null);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = resultAnswerEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.resultId, equals(1));
        expect(result.questionId, equals(1));
        expect(result.optionId, equals(1));
      });

      test('should handle different values', () {
        // Arrange
        const entity = ResultAnswer(id: 5, resultId: 10, questionId: 15, optionId: 20);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(5));
        expect(result.resultId, equals(10));
        expect(result.questionId, equals(15));
        expect(result.optionId, equals(20));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = resultAnswerModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(resultAnswerModel.id));
        expect(backToModel.resultId, equals(resultAnswerModel.resultId));
        expect(backToModel.questionId, equals(resultAnswerModel.questionId));
        expect(backToModel.optionId, equals(resultAnswerModel.optionId));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = resultAnswerEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(resultAnswerEntity.id));
        expect(backToEntity.resultId, equals(resultAnswerEntity.resultId));
        expect(backToEntity.questionId, equals(resultAnswerEntity.questionId));
        expect(backToEntity.optionId, equals(resultAnswerEntity.optionId));
      });

      test('should handle null optionId in round-trip conversion', () {
        // Arrange
        const model = ResultAnswerModel(id: 1, resultId: 1, questionId: 1, optionId: null);

        // Act
        final entity = model.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(model.id));
        expect(backToModel.resultId, equals(model.resultId));
        expect(backToModel.questionId, equals(model.questionId));
        expect(backToModel.optionId, isNull);
      });
    });
  });
}
