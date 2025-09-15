import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/data/mappers/option_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';

void main() {
  group('OptionMapper', () {
    late OptionModel optionModel;
    late Option optionEntity;

    setUp(() {
      optionModel = const OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: true);

      optionEntity = const Option(id: 1, questionId: 1, content: 'Option 1', isCorrect: true);
    });

    group('OptionModelExtension.toEntity', () {
      test('should convert OptionModel to Option entity', () {
        // Act
        final result = optionModel.toEntity();

        // Assert
        expect(result, isA<Option>());
        expect(result.id, equals(optionModel.id));
        expect(result.questionId, equals(optionModel.questionId));
        expect(result.content, equals(optionModel.content));
        expect(result.isCorrect, equals(optionModel.isCorrect));
      });

      test('should handle null isCorrect field', () {
        // Arrange
        const model = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = optionModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, equals(true));
      });

      test('should handle different values', () {
        // Arrange
        const model = OptionModel(
          id: 5,
          questionId: 10,
          content: 'Different Option',
          isCorrect: false,
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(5));
        expect(result.questionId, equals(10));
        expect(result.content, equals('Different Option'));
        expect(result.isCorrect, equals(false));
      });
    });

    group('OptionEntityExtension.toModel', () {
      test('should convert Option entity to OptionModel', () {
        // Act
        final result = optionEntity.toModel();

        // Assert
        expect(result, isA<OptionModel>());
        expect(result.id, equals(optionEntity.id));
        expect(result.questionId, equals(optionEntity.questionId));
        expect(result.content, equals(optionEntity.content));
        expect(result.isCorrect, equals(optionEntity.isCorrect));
      });

      test('should handle null isCorrect field', () {
        // Arrange
        const entity = Option(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = optionEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, equals(true));
      });

      test('should handle different values', () {
        // Arrange
        const entity = Option(id: 5, questionId: 10, content: 'Different Option', isCorrect: false);

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(5));
        expect(result.questionId, equals(10));
        expect(result.content, equals('Different Option'));
        expect(result.isCorrect, equals(false));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = optionModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(optionModel.id));
        expect(backToModel.questionId, equals(optionModel.questionId));
        expect(backToModel.content, equals(optionModel.content));
        expect(backToModel.isCorrect, equals(optionModel.isCorrect));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = optionEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(optionEntity.id));
        expect(backToEntity.questionId, equals(optionEntity.questionId));
        expect(backToEntity.content, equals(optionEntity.content));
        expect(backToEntity.isCorrect, equals(optionEntity.isCorrect));
      });

      test('should handle null isCorrect in round-trip conversion', () {
        // Arrange
        const model = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);

        // Act
        final entity = model.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(model.id));
        expect(backToModel.questionId, equals(model.questionId));
        expect(backToModel.content, equals(model.content));
        expect(backToModel.isCorrect, isNull);
      });
    });
  });
}
