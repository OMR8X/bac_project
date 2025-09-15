import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/unit_model.dart';
import 'package:bac_project/features/tests/domain/entities/unit.dart';

void main() {
  group('UnitModel', () {
    late UnitModel unitModel;

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
    });

    group('fromJson', () {
      test('should create UnitModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Unit 1',
          'subtitle': 'Introduction to Programming',
          'lessons_count': 5,
          'icon': 'https://example.com/icon.png',
          'created_at': '2023-01-01T10:00:00Z',
          'updated_at': '2023-01-01T10:05:00Z',
        };

        // Act
        final result = UnitModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, equals(5));
        expect(result.icon, equals('https://example.com/icon.png'));
        expect(result.createdAt, equals(DateTime.parse('2023-01-01T10:00:00Z')));
        expect(result.updatedAt, equals(DateTime.parse('2023-01-01T10:05:00Z')));
      });

      test('should create UnitModel from JSON with null optional fields', () {
        // Arrange
        final json = {'id': 1, 'title': 'Unit 1', 'subtitle': 'Introduction to Programming'};

        // Act
        final result = UnitModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Unit 1'));
        expect(result.subtitle, equals('Introduction to Programming'));
        expect(result.lessonsCount, isNull);
        expect(result.icon, isNull);
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });

      test('should handle null date strings', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Unit 1',
          'subtitle': 'Introduction to Programming',
          'lessons_count': 5,
          'icon': 'https://example.com/icon.png',
          'created_at': null,
          'updated_at': null,
        };

        // Act
        final result = UnitModel.fromJson(json);

        // Assert
        expect(result.createdAt, isNull);
        expect(result.updatedAt, isNull);
      });
    });

    group('toJson', () {
      test('should convert UnitModel to JSON', () {
        // Act
        final result = unitModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['title'], equals('Unit 1'));
        expect(result['subtitle'], equals('Introduction to Programming'));
        expect(result['lessons_count'], equals(5));
        expect(result['icon'], equals('https://example.com/icon.png'));
        expect(result['created_at'], isNull);
        expect(result['updated_at'], isNull);
      });

      test('should handle null optional fields in JSON', () {
        // Arrange
        const model = UnitModel(id: 1, title: 'Unit 1', subtitle: 'Introduction to Programming');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['lessons_count'], isNull);
        expect(result['icon'], isNull);
        expect(result['created_at'], isNull);
        expect(result['updated_at'], isNull);
      });

      test('should convert DateTime to ISO string', () {
        // Arrange
        final model = const UnitModel(
          id: 1,
          title: 'Unit 1',
          subtitle: 'Introduction to Programming',
          lessonsCount: 5,
          icon: 'https://example.com/icon.png',
          createdAt: null,
          updatedAt: null,
        ).copyWith(
          createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T10:05:00Z'),
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['created_at'], equals('2023-01-01T10:00:00.000Z'));
        expect(result['updated_at'], equals('2023-01-01T10:05:00.000Z'));
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = unitModel.copyWith(title: 'Updated Unit 1', lessonsCount: 10);

        // Assert
        expect(result.id, equals(unitModel.id));
        expect(result.title, equals('Updated Unit 1'));
        expect(result.subtitle, equals(unitModel.subtitle));
        expect(result.lessonsCount, equals(10));
        expect(result.icon, equals(unitModel.icon));
        expect(result.createdAt, equals(unitModel.createdAt));
        expect(result.updatedAt, equals(unitModel.updatedAt));
      });

      test('should create copy with all fields updated', () {
        // Act
        final result = unitModel.copyWith(
          id: 2,
          title: 'Unit 2',
          subtitle: 'Advanced Programming',
          lessonsCount: 8,
          icon: 'https://example.com/new_icon.png',
          createdAt: DateTime.parse('2023-01-02T10:00:00Z'),
          updatedAt: DateTime.parse('2023-01-02T10:10:00Z'),
        );

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Unit 2'));
        expect(result.subtitle, equals('Advanced Programming'));
        expect(result.lessonsCount, equals(8));
        expect(result.icon, equals('https://example.com/new_icon.png'));
        expect(result.createdAt, equals(DateTime.parse('2023-01-02T10:00:00Z')));
        expect(result.updatedAt, equals(DateTime.parse('2023-01-02T10:10:00Z')));
      });

      test('should create copy with no changes when no parameters provided', () {
        // Act
        final result = unitModel.copyWith();

        // Assert
        expect(result.id, equals(unitModel.id));
        expect(result.title, equals(unitModel.title));
        expect(result.subtitle, equals(unitModel.subtitle));
        expect(result.lessonsCount, equals(unitModel.lessonsCount));
        expect(result.icon, equals(unitModel.icon));
        expect(result.createdAt, equals(unitModel.createdAt));
        expect(result.updatedAt, equals(unitModel.updatedAt));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const other = UnitModel(
          id: 1,
          title: 'Unit 1',
          subtitle: 'Introduction to Programming',
          lessonsCount: 5,
          icon: 'https://example.com/icon.png',
          createdAt: null,
          updatedAt: null,
        );

        // Assert
        expect(unitModel, equals(other));
        expect(unitModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        const other = UnitModel(
          id: 2,
          title: 'Unit 1',
          subtitle: 'Introduction to Programming',
          lessonsCount: 5,
          icon: 'https://example.com/icon.png',
          createdAt: null,
          updatedAt: null,
        );

        // Assert
        expect(unitModel, isNot(equals(other)));
      });

      test('should handle null values in equality', () {
        // Arrange
        const model1 = UnitModel(
          id: 1,
          title: 'Unit 1',
          subtitle: 'Introduction to Programming',
          lessonsCount: null,
          icon: null,
          createdAt: null,
          updatedAt: null,
        );
        const model2 = UnitModel(
          id: 1,
          title: 'Unit 1',
          subtitle: 'Introduction to Programming',
          lessonsCount: null,
          icon: null,
          createdAt: null,
          updatedAt: null,
        );

        // Assert
        expect(model1, equals(model2));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = unitModel.toString();

        // Assert
        expect(result, contains('UnitModel'));
        expect(result, contains('id: 1'));
        expect(result, contains('title: Unit 1'));
        expect(result, contains('subtitle: Introduction to Programming'));
        expect(result, contains('lessonsCount: 5'));
        expect(result, contains('icon: https://example.com/icon.png'));
      });
    });

    group('inheritance', () {
      test('should be instance of Unit', () {
        // Assert
        expect(unitModel, isA<Unit>());
      });
    });
  });
}
