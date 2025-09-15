import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/unit_model.dart';
import 'package:bac_project/features/tests/data/mappers/unit_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/unit.dart';

void main() {
  group('UnitMapper', () {
    late UnitModel unitModel;
    late Unit unitEntity;

    setUp(() {
      unitModel = const UnitModel(
        id: 1,
        title: 'Unit 1',
        subtitle: 'Introduction to Programming',
        lessonsCount: 5,
        icon: 'https://example.com/icon.png',
        createdAt: null,
        updatedAt: null,
      );

      unitEntity = const Unit(
        id: 1,
        title: 'Unit 1',
        subtitle: 'Introduction to Programming',
        lessonsCount: 5,
        icon: 'https://example.com/icon.png',
        createdAt: null,
        updatedAt: null,
      );
    });

    group('UnitModelExtension.toEntity', () {
      test('should convert UnitModel to Unit entity', () {
        // Act
        final result = unitModel.toEntity();

        // Assert
        expect(result, isA<Unit>());
        expect(result.id, equals(unitModel.id));
        expect(result.title, equals(unitModel.title));
        expect(result.subtitle, equals(unitModel.subtitle));
        expect(result.lessonsCount, equals(unitModel.lessonsCount));
        expect(result.icon, equals(unitModel.icon));
        expect(result.createdAt, equals(unitModel.createdAt));
        expect(result.updatedAt, equals(unitModel.updatedAt));
      });

      test('should handle null optional fields', () {
        // Arrange
        const model = UnitModel(id: 1, title: 'Unit 1', subtitle: 'Introduction to Programming');

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, isNull);
        expect(result.icon, isNull);
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = unitModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, equals(5));
        expect(result.icon, equals('https://example.com/icon.png'));
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });

      test('should handle different values', () {
        // Arrange
        final model = const UnitModel(
          id: 5,
          title: 'Advanced Unit',
          subtitle: 'Advanced Programming Concepts',
          lessonsCount: 10,
          icon: 'https://example.com/advanced_icon.png',
          createdAt: null,
          updatedAt: null,
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Advanced Unit'));
        expect(result.subtitle, equals('Advanced Programming Concepts'));
        expect(result.lessonsCount, equals(10));
        expect(result.icon, equals('https://example.com/advanced_icon.png'));
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });
    });

    group('UnitEntityExtension.toModel', () {
      test('should convert Unit entity to UnitModel', () {
        // Act
        final result = unitEntity.toModel();

        // Assert
        expect(result, isA<UnitModel>());
        expect(result.id, equals(unitEntity.id));
        expect(result.title, equals(unitEntity.title));
        expect(result.subtitle, equals(unitEntity.subtitle));
        expect(result.lessonsCount, equals(unitEntity.lessonsCount));
        expect(result.icon, equals(unitEntity.icon));
        expect(result.createdAt, equals(unitEntity.createdAt));
        expect(result.updatedAt, equals(unitEntity.updatedAt));
      });

      test('should handle null optional fields', () {
        // Arrange
        const entity = Unit(id: 1, title: 'Unit 1', subtitle: 'Introduction to Programming');

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, isNull);
        expect(result.icon, isNull);
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = unitEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, equals(5));
        expect(result.icon, equals('https://example.com/icon.png'));
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });

      test('should handle different values', () {
        // Arrange
        const entity = Unit(
          id: 5,
          title: 'Advanced Unit',
          subtitle: 'Advanced Programming Concepts',
          lessonsCount: 10,
          icon: 'https://example.com/advanced_icon.png',
          createdAt: null,
          updatedAt: null,
        );

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Advanced Unit'));
        expect(result.subtitle, equals('Advanced Programming Concepts'));
        expect(result.lessonsCount, equals(10));
        expect(result.icon, equals('https://example.com/advanced_icon.png'));
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = unitModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(unitModel.id));
        expect(backToModel.title, equals(unitModel.title));
        expect(backToModel.subtitle, equals(unitModel.subtitle));
        expect(backToModel.lessonsCount, equals(unitModel.lessonsCount));
        expect(backToModel.icon, equals(unitModel.icon));
        expect(backToModel.createdAt, equals(unitModel.createdAt));
        expect(backToModel.updatedAt, equals(unitModel.updatedAt));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = unitEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(unitEntity.id));
        expect(backToEntity.title, equals(unitEntity.title));
        expect(backToEntity.subtitle, equals(unitEntity.subtitle));
        expect(backToEntity.lessonsCount, equals(unitEntity.lessonsCount));
        expect(backToEntity.icon, equals(unitEntity.icon));
        expect(backToEntity.createdAt, equals(unitEntity.createdAt));
        expect(backToEntity.updatedAt, equals(unitEntity.updatedAt));
      });

      test('should handle null optional fields in round-trip conversion', () {
        // Arrange
        const model = UnitModel(id: 1, title: 'Unit 1', subtitle: 'Introduction to Programming');

        // Act
        final entity = model.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(model.id));
        expect(backToModel.title, equals(model.title));
        expect(backToModel.subtitle, equals(model.subtitle));
        expect(backToModel.lessonsCount, isNull);
        expect(backToModel.icon, isNull);
        expect(backToModel.createdAt, isNull);
        expect(backToModel.updatedAt, isNull);
      });
    });
  });
}
