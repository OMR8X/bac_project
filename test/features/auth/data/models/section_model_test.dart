import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';

void main() {
  group('SectionModel', () {
    late SectionModel sectionModel;

    setUp(() {
      sectionModel = const SectionModel(id: 1, title: 'Scientific Section');
    });

    group('fromJson', () {
      test('should create SectionModel from valid JSON', () {
        // Arrange
        final json = {'id': 1, 'title': 'Scientific Section'};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.title, equals('Scientific Section'));
      });

      test('should create SectionModel with different values', () {
        // Arrange
        final json = {'id': 2, 'title': 'Literary Section'};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Literary Section'));
      });

      test('should handle string id conversion', () {
        // Arrange
        final json = {'id': 3, 'title': 'Math Section'};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(3));
        expect(result.title, equals('Math Section'));
      });

      test('should handle empty title', () {
        // Arrange
        final json = {'id': 4, 'title': ''};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(4));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        final json = {'id': 999999, 'title': 'Large ID Section'};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(999999));
        expect(result.title, equals('Large ID Section'));
      });

      test('should handle special characters in title', () {
        // Arrange
        final json = {'id': 5, 'title': 'Section with Special Characters: @#\$%^&*()'};

        // Act
        final result = SectionModel.fromJson(json);

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Section with Special Characters: @#\$%^&*()'));
      });
    });

    group('toJson', () {
      test('should convert SectionModel to JSON', () {
        // Act
        final result = sectionModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['title'], equals('Scientific Section'));
      });

      test('should convert different SectionModel to JSON', () {
        // Arrange
        const model = SectionModel(id: 6, title: 'Art Section');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(6));
        expect(result['title'], equals('Art Section'));
      });

      test('should handle empty title in JSON', () {
        // Arrange
        const model = SectionModel(id: 7, title: '');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(7));
        expect(result['title'], equals(''));
      });

      test('should handle zero id in JSON', () {
        // Arrange
        const model = SectionModel(id: 0, title: 'Zero ID Section');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(0));
        expect(result['title'], equals('Zero ID Section'));
      });

      test('should handle special characters in JSON', () {
        // Arrange
        const model = SectionModel(id: 8, title: 'Section with Unicode: Chinese Arabic');

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals(8));
        expect(result['title'], equals('Section with Unicode: Chinese Arabic'));
      });
    });

    group('inheritance', () {
      test('should be instance of Section', () {
        // Assert
        expect(sectionModel, isA<Section>());
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const other = SectionModel(id: 1, title: 'Scientific Section');

        // Assert
        expect(sectionModel, equals(other));
        expect(sectionModel.hashCode, equals(other.hashCode));
      });

      test('should not be equal when id differs', () {
        // Arrange
        const other = SectionModel(id: 2, title: 'Scientific Section');

        // Assert
        expect(sectionModel, isNot(equals(other)));
      });

      test('should not be equal when title differs', () {
        // Arrange
        const other = SectionModel(id: 1, title: 'Literary Section');

        // Assert
        expect(sectionModel, isNot(equals(other)));
      });
    });

    group('toString', () {
      test('should return string representation', () {
        // Act
        final result = sectionModel.toString();

        // Assert
        expect(result, contains('SectionModel'));
        expect(result, contains('1'));
        expect(result, contains('Scientific Section'));
      });
    });

    group('const constructor', () {
      test('should create const instance', () {
        // Act
        const model = SectionModel(id: 9, title: 'Const Test Section');

        // Assert
        expect(model.id, equals(9));
        expect(model.title, equals('Const Test Section'));
      });
    });
  });
}
