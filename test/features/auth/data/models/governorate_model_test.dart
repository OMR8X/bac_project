import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/governorate_model.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';

void main() {
  group('GovernorateModel', () {
    late GovernorateModel governorateModel;

    setUp(() {
      governorateModel = const GovernorateModel(id: 1, title: 'Cairo');
    });

    group('fromJson', () {
      test('should create GovernorateModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'title': 'Cairo'};

        // Act
        final result = GovernorateModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Cairo'));
      });

      test('should create GovernorateModel with different values', () {
        // Arrange
        final json = {'id': 2, 'title': 'Alexandria'};

        // Act
        final result = GovernorateModel.fromJson(json);

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Alexandria'));
      });

      test('should handle numeric id', () {
        // Arrange
        final json = {'id': 3, 'title': 'Giza'};

        // Act
        final result = GovernorateModel.fromJson(json);

        // Assert
        expect(result.id, equals(3));
        expect(result.title, equals('Giza'));
      });

      test('should handle empty title', () {
        // Arrange
        final json = {'id': 4, 'title': ''};

        // Act
        final result = GovernorateModel.fromJson(json);

        // Assert
        expect(result.id, equals(4));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        final json = {'id': 999999, 'title': 'Large ID Governorate'};

        // Act
        final result = GovernorateModel.fromJson(json);

        // Assert
        expect(result.id, equals(999999));
        expect(result.title, equals('Large ID Governorate'));
      });
    });

    group('toJson', () {
      test('should convert GovernorateModel to JSON', () {
        // Act
        final result = governorateModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['title'], equals('Cairo'));
      });

      test('should convert different GovernorateModel to JSON', () {
        // Arrange
        const model = GovernorateModel(id: 5, title: 'Aswan');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(5));
        expect(result['title'], equals('Aswan'));
      });

      test('should handle empty title in JSON', () {
        // Arrange
        const model = GovernorateModel(id: 6, title: '');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(6));
        expect(result['title'], equals(''));
      });

      test('should handle zero id in JSON', () {
        // Arrange
        const model = GovernorateModel(id: 0, title: 'Zero ID');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(0));
        expect(result['title'], equals('Zero ID'));
      });
    });

    group('inheritance', () {
      test('should be instance of Governorate', () {
        // Assert
        expect(governorateModel, isA<Governorate>());
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const other = GovernorateModel(id: 1, title: 'Cairo');

        // Assert
        expect(governorateModel, equals(other));
        expect(governorateModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when id differs', () {
        // Arrange
        const other = GovernorateModel(id: 2, title: 'Cairo');

        // Assert
        expect(governorateModel, isNot(equals(other)));
      });

      test('should not be equal when title differs', () {
        // Arrange
        const other = GovernorateModel(id: 1, title: 'Alexandria');

        // Assert
        expect(governorateModel, isNot(equals(other)));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = governorateModel.toString();

        // Assert
        expect(result, contains('GovernorateModel'));
        expect(result, contains('1'));
        expect(result, contains('Cairo'));
      });
    });

    group('const constructor', () {
      test('should create const instance', () {
        // Act
        const model = GovernorateModel(id: 7, title: 'Const Test');

        // Assert
        expect(model.id, equals(7));
        expect(model.title, equals('Const Test'));
      });
    });
  });
}
