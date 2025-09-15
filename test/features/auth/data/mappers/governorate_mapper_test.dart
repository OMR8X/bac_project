import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/governorate_model.dart';
import 'package:bac_project/features/auth/data/mappers/governorate_mappers.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';

void main() {
  group('GovernorateMapper', () {
    late Governorate governorateEntity;
    late GovernorateModel governorateModel;

    setUp(() {
      governorateEntity = const Governorate(id: 1, title: 'Cairo');

      governorateModel = const GovernorateModel(id: 1, title: 'Cairo');
    });

    group('GovernorateMapper.toModel', () {
      test('should convert Governorate entity to GovernorateModel', () {
        // Act
        final result = governorateEntity.toModel;

        // Assert
        expect(result, isA<GovernorateModel>());
        expect(result.id, equals(governorateEntity.id));
        expect(result.title, equals(governorateEntity.title));
      });

      test('should handle different values', () {
        // Arrange
        const entity = Governorate(id: 2, title: 'Alexandria');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Alexandria'));
      });

      test('should handle empty title', () {
        // Arrange
        const entity = Governorate(id: 3, title: '');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(3));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        const entity = Governorate(id: 999999, title: 'Large ID Governorate');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(999999));
        expect(result.title, equals('Large ID Governorate'));
      });

      test('should handle special characters in title', () {
        // Arrange
        const entity = Governorate(id: 4, title: 'Governorate with Special Chars: @#\$%^&*()');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(4));
        expect(result.title, equals('Governorate with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in title', () {
        // Arrange
        const entity = Governorate(id: 5, title: 'Governorate with Unicode: Chinese Arabic');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Governorate with Unicode: Chinese Arabic'));
      });
    });

    group('GovernorateModelMapper.toEntity', () {
      test('should convert GovernorateModel to Governorate entity', () {
        // Act
        final result = governorateModel.toEntity;

        // Assert
        expect(result, isA<Governorate>());
        expect(result.id, equals(governorateModel.id));
        expect(result.title, equals(governorateModel.title));
      });

      test('should handle different values', () {
        // Arrange
        const model = GovernorateModel(id: 6, title: 'Giza');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(6));
        expect(result.title, equals('Giza'));
      });

      test('should handle empty title', () {
        // Arrange
        const model = GovernorateModel(id: 7, title: '');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(7));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        const model = GovernorateModel(id: 888888, title: 'Another Large ID Governorate');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(888888));
        expect(result.title, equals('Another Large ID Governorate'));
      });

      test('should handle special characters in title', () {
        // Arrange
        const model = GovernorateModel(id: 8, title: 'Model with Special Chars: @#\$%^&*()');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(8));
        expect(result.title, equals('Model with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in title', () {
        // Arrange
        const model = GovernorateModel(id: 9, title: 'Model with Unicode: Chinese Arabic');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(9));
        expect(result.title, equals('Model with Unicode: Chinese Arabic'));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = governorateEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(governorateEntity.id));
        expect(backToEntity.title, equals(governorateEntity.title));
      });

      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = governorateModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals(governorateModel.id));
        expect(backToModel.title, equals(governorateModel.title));
      });

      test('should handle empty title in round-trip conversion', () {
        // Arrange
        const entity = Governorate(id: 10, title: '');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(10));
        expect(backToEntity.title, equals(''));
      });

      test('should handle special characters in round-trip conversion', () {
        // Arrange
        const entity = Governorate(id: 11, title: 'Round-trip with Special Chars: @#\$%^&*()');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(11));
        expect(backToEntity.title, equals('Round-trip with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in round-trip conversion', () {
        // Arrange
        const entity = Governorate(id: 12, title: 'Round-trip with Unicode: Chinese Arabic');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(12));
        expect(backToEntity.title, equals('Round-trip with Unicode: Chinese Arabic'));
      });
    });
  });
}
