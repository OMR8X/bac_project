import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/auth/data/mappers/section_mappers.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';

void main() {
  group('SectionMapper', () {
    late Section sectionEntity;
    late SectionModel sectionModel;

    setUp(() {
      sectionEntity = const Section(id: 1, title: 'Scientific Section');

      sectionModel = const SectionModel(id: 1, title: 'Scientific Section');
    });

    group('SectionMapper.toModel', () {
      test('should convert Section entity to SectionModel', () {
        // Act
        final result = sectionEntity.toModel;

        // Assert
        expect(result, isA<SectionModel>());
        expect(result.id, equals(sectionEntity.id));
        expect(result.title, equals(sectionEntity.title));
      });

      test('should handle different values', () {
        // Arrange
        const entity = Section(id: 2, title: 'Literary Section');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(2));
        expect(result.title, equals('Literary Section'));
      });

      test('should handle empty title', () {
        // Arrange
        const entity = Section(id: 3, title: '');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(3));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        const entity = Section(id: 999999, title: 'Large ID Section');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(999999));
        expect(result.title, equals('Large ID Section'));
      });

      test('should handle special characters in title', () {
        // Arrange
        const entity = Section(id: 4, title: 'Section with Special Chars: @#\$%^&*()');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(4));
        expect(result.title, equals('Section with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in title', () {
        // Arrange
        const entity = Section(id: 5, title: 'Section with Unicode: Chinese Arabic');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(5));
        expect(result.title, equals('Section with Unicode: Chinese Arabic'));
      });

      test('should handle very long titles', () {
        // Arrange
        const entity = Section(
          id: 6,
          title:
              'This is a very long section title that contains many words and should be handled properly by the mapper without any issues or truncation',
        );

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals(6));
        expect(
          result.title,
          equals(
            'This is a very long section title that contains many words and should be handled properly by the mapper without any issues or truncation',
          ),
        );
      });
    });

    group('SectionModelMapper.toEntity', () {
      test('should convert SectionModel to Section entity', () {
        // Act
        final result = sectionModel.toEntity;

        // Assert
        expect(result, isA<Section>());
        expect(result.id, equals(sectionModel.id));
        expect(result.title, equals(sectionModel.title));
      });

      test('should handle different values', () {
        // Arrange
        const model = SectionModel(id: 7, title: 'Math Section');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(7));
        expect(result.title, equals('Math Section'));
      });

      test('should handle empty title', () {
        // Arrange
        const model = SectionModel(id: 8, title: '');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(8));
        expect(result.title, equals(''));
      });

      test('should handle large id values', () {
        // Arrange
        const model = SectionModel(id: 888888, title: 'Another Large ID Section');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(888888));
        expect(result.title, equals('Another Large ID Section'));
      });

      test('should handle special characters in title', () {
        // Arrange
        const model = SectionModel(id: 9, title: 'Model with Special Chars: @#\$%^&*()');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(9));
        expect(result.title, equals('Model with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in title', () {
        // Arrange
        const model = SectionModel(id: 10, title: 'Model with Unicode: Chinese Arabic');

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(10));
        expect(result.title, equals('Model with Unicode: Chinese Arabic'));
      });

      test('should handle very long titles', () {
        // Arrange
        const model = SectionModel(
          id: 11,
          title:
              'This is another very long section title that contains many words and should be handled properly by the mapper without any issues or truncation',
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals(11));
        expect(
          result.title,
          equals(
            'This is another very long section title that contains many words and should be handled properly by the mapper without any issues or truncation',
          ),
        );
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = sectionEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(sectionEntity.id));
        expect(backToEntity.title, equals(sectionEntity.title));
      });

      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = sectionModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals(sectionModel.id));
        expect(backToModel.title, equals(sectionModel.title));
      });

      test('should handle empty title in round-trip conversion', () {
        // Arrange
        const entity = Section(id: 12, title: '');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(12));
        expect(backToEntity.title, equals(''));
      });

      test('should handle special characters in round-trip conversion', () {
        // Arrange
        const entity = Section(id: 13, title: 'Round-trip with Special Chars: @#\$%^&*()');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(13));
        expect(backToEntity.title, equals('Round-trip with Special Chars: @#\$%^&*()'));
      });

      test('should handle unicode characters in round-trip conversion', () {
        // Arrange
        const entity = Section(id: 14, title: 'Round-trip with Unicode: Chinese Arabic');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(14));
        expect(backToEntity.title, equals('Round-trip with Unicode: Chinese Arabic'));
      });

      test('should handle very long titles in round-trip conversion', () {
        // Arrange
        const entity = Section(
          id: 15,
          title:
              'This is a very long section title for round-trip testing that contains many words and should be handled properly by the mapper without any issues or truncation',
        );

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(15));
        expect(
          backToEntity.title,
          equals(
            'This is a very long section title for round-trip testing that contains many words and should be handled properly by the mapper without any issues or truncation',
          ),
        );
      });
    });
  });
}
