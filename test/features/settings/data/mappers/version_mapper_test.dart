import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/version_model.dart';
import 'package:bac_project/features/settings/data/mappers/version_mappers.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';

void main() {
  group('VersionMapper', () {
    late Version versionEntity;
    late VersionModel versionModel;

    setUp(() {
      versionEntity = const Version(
        id: '1',
        currentVersion: '1.0.0',
        minimumVersion: '1.0.0',
        updateLink: 'https://example.com/update',
        appVersion: '1.0.0',
      );

      versionModel = const VersionModel(
        id: '1',
        currentVersion: '1.0.0',
        minimumVersion: '1.0.0',
        updateLink: 'https://example.com/update',
        appVersion: '1.0.0',
      );
    });

    group('VersionMapper.toModel', () {
      test('should convert Version entity to VersionModel', () {
        // Act
        final result = versionEntity.toModel;

        // Assert
        expect(result, isA<VersionModel>());
        expect(result.id, equals(versionEntity.id));
        expect(result.currentVersion, equals(versionEntity.currentVersion));
        expect(result.minimumVersion, equals(versionEntity.minimumVersion));
        expect(result.updateLink, equals(versionEntity.updateLink));
        expect(result.appVersion, equals(versionEntity.appVersion));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = versionEntity.toModel;

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should handle default appVersion', () {
        // Arrange
        const entity = Version(
          id: '1',
          currentVersion: '1.0.0',
          minimumVersion: '1.0.0',
          updateLink: 'https://example.com/update',
        );

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should handle different values', () {
        // Arrange
        const entity = Version(
          id: '2',
          currentVersion: '2.0.0',
          minimumVersion: '1.5.0',
          updateLink: 'https://example.com/update2',
          appVersion: '2.0.0',
        );

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.id, equals('2'));
        expect(result.currentVersion, equals('2.0.0'));
        expect(result.minimumVersion, equals('1.5.0'));
        expect(result.updateLink, equals('https://example.com/update2'));
        expect(result.appVersion, equals('2.0.0'));
      });
    });

    group('VersionModelMapper.toEntity', () {
      test('should convert VersionModel to Version entity', () {
        // Act
        final result = versionModel.toEntity;

        // Assert
        expect(result, isA<Version>());
        expect(result.id, equals(versionModel.id));
        expect(result.currentVersion, equals(versionModel.currentVersion));
        expect(result.minimumVersion, equals(versionModel.minimumVersion));
        expect(result.updateLink, equals(versionModel.updateLink));
        expect(result.appVersion, equals(versionModel.appVersion));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = versionModel.toEntity;

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should handle default appVersion', () {
        // Arrange
        const model = VersionModel(
          id: '1',
          currentVersion: '1.0.0',
          minimumVersion: '1.0.0',
          updateLink: 'https://example.com/update',
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should handle different values', () {
        // Arrange
        const model = VersionModel(
          id: '2',
          currentVersion: '2.0.0',
          minimumVersion: '1.5.0',
          updateLink: 'https://example.com/update2',
          appVersion: '2.0.0',
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.id, equals('2'));
        expect(result.currentVersion, equals('2.0.0'));
        expect(result.minimumVersion, equals('1.5.0'));
        expect(result.updateLink, equals('https://example.com/update2'));
        expect(result.appVersion, equals('2.0.0'));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = versionModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals(versionModel.id));
        expect(backToModel.currentVersion, equals(versionModel.currentVersion));
        expect(backToModel.minimumVersion, equals(versionModel.minimumVersion));
        expect(backToModel.updateLink, equals(versionModel.updateLink));
        expect(backToModel.appVersion, equals(versionModel.appVersion));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = versionEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.id, equals(versionEntity.id));
        expect(backToEntity.currentVersion, equals(versionEntity.currentVersion));
        expect(backToEntity.minimumVersion, equals(versionEntity.minimumVersion));
        expect(backToEntity.updateLink, equals(versionEntity.updateLink));
        expect(backToEntity.appVersion, equals(versionEntity.appVersion));
      });

      test('should handle default appVersion in round-trip conversion', () {
        // Arrange
        const model = VersionModel(
          id: '1',
          currentVersion: '1.0.0',
          minimumVersion: '1.0.0',
          updateLink: 'https://example.com/update',
        );

        // Act
        final entity = model.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals('1'));
        expect(backToModel.currentVersion, equals('1.0.0'));
        expect(backToModel.minimumVersion, equals('1.0.0'));
        expect(backToModel.updateLink, equals('https://example.com/update'));
        expect(backToModel.appVersion, equals('1.0.0'));
      });

      test('should handle different values in round-trip conversion', () {
        // Arrange
        const model = VersionModel(
          id: '5',
          currentVersion: '3.0.0',
          minimumVersion: '2.0.0',
          updateLink: 'https://example.com/update3',
          appVersion: '3.0.0',
        );

        // Act
        final entity = model.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.id, equals('5'));
        expect(backToModel.currentVersion, equals('3.0.0'));
        expect(backToModel.minimumVersion, equals('2.0.0'));
        expect(backToModel.updateLink, equals('https://example.com/update3'));
        expect(backToModel.appVersion, equals('3.0.0'));
      });
    });
  });
}
