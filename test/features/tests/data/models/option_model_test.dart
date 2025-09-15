import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';

void main() {
  group('OptionModel', () {
    late OptionModel optionModel;

    setUp(() {
      optionModel = const OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: true);
    });

    group('fromJson', () {
      test('should create OptionModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'question_id': 1, 'content': 'Option 1', 'is_correct': true};

        // Act
        final result = OptionModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, equals(true));
      });

      test('should create OptionModel with default values for null fields', () {
        // Arrange
        final json = {'content': 'Option 1'};

        // Act
        final result = OptionModel.fromJson(json);

        // Assert
        expect(result.id, isA<int>());
        expect(result.questionId, isA<int>());
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, isNull);
      });

      test('should handle null isCorrect field', () {
        // Arrange
        final json = {'id': 1, 'question_id': 1, 'content': 'Option 1', 'is_correct': null};

        // Act
        final result = OptionModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, isNull);
      });
    });

    group('toJson', () {
      test('should convert OptionModel to JSON', () {
        // Act
        final result = optionModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['question_id'], equals(1));
        expect(result['content'], equals('Option 1'));
        expect(result['is_correct'], equals(true));
      });

      test('should handle null isCorrect in JSON', () {
        // Arrange
        const model = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);

        // Act
        final result = model.toJson();

        // Assert
        expect(result['is_correct'], isNull);
      });
    });

    group('toEntity', () {
      test('should convert OptionModel to Option entity', () {
        // Act
        final result = optionModel.toEntity();

        // Assert
        expect(result, isA<Option>());
        expect(result.id, equals(1));
        expect(result.questionId, equals(1));
        expect(result.content, equals('Option 1'));
        expect(result.isCorrect, equals(true));
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = optionModel.copyWith(content: 'Updated option', isCorrect: false);

        // Assert
        expect(result.id, equals(optionModel.id));
        expect(result.questionId, equals(optionModel.questionId));
        expect(result.content, equals('Updated option'));
        expect(result.isCorrect, equals(false));
      });

      test('should create copy with all fields updated', () {
        // Act
        final result = optionModel.copyWith(
          id: 2,
          questionId: 2,
          content: 'New option',
          isCorrect: false,
        );

        // Assert
        expect(result.id, equals(2));
        expect(result.questionId, equals(2));
        expect(result.content, equals('New option'));
        expect(result.isCorrect, equals(false));
      });

      test('should create copy with no changes when no parameters provided', () {
        // Act
        final result = optionModel.copyWith();

        // Assert
        expect(result.id, equals(optionModel.id));
        expect(result.questionId, equals(optionModel.questionId));
        expect(result.content, equals(optionModel.content));
        expect(result.isCorrect, equals(optionModel.isCorrect));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const other = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: true);

        // Assert
        expect(optionModel, equals(other));
        expect(optionModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        const other = OptionModel(id: 2, questionId: 1, content: 'Option 1', isCorrect: true);

        // Assert
        expect(optionModel, isNot(equals(other)));
      });

      test('should handle null isCorrect in equality', () {
        // Arrange
        const model1 = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);
        const model2 = OptionModel(id: 1, questionId: 1, content: 'Option 1', isCorrect: null);

        // Assert
        expect(model1, equals(model2));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = optionModel.toString();

        // Assert
        expect(result, contains('OptionModel'));
        expect(result, contains('id: 1'));
        expect(result, contains('questionId: 1'));
        expect(result, contains('content: Option 1'));
        expect(result, contains('isCorrect: true'));
      });
    });

    group('inheritance', () {
      test('should be instance of Option', () {
        // Assert
        expect(optionModel, isA<Option>());
      });
    });
  });
}
