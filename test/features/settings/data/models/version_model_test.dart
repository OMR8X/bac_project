import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/version_model.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';

void main() {
  group('VersionModel', () {
    late VersionModel versionModel;

    setUp(() {
      versionModel = const VersionModel(
        id: '1',
        currentVersion: '1.0.0',
        minimumVersion: '1.0.0',
        updateLink: 'https://example.com/update',
        appVersion: '1.0.0',
      );
    });

    group('fromJson', () {
      test('should create VersionModel from valid JSON', () {
        // Arrange
        final json = {
          'id': '1',
          'current_version': '1.0.0',
          'minimum_version': '1.0.0',
          'update_link': 'https://example.com/update',
          'app_version': '1.0.0',
        };

        // Act
        final result = VersionModel.fromJson(json);

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should create VersionModel with different values', () {
        // Arrange
        final json = {
          'id': '2',
          'current_version': '2.0.0',
          'minimum_version': '1.5.0',
          'update_link': 'https://example.com/update2',
          'app_version': '2.0.0',
        };

        // Act
        final result = VersionModel.fromJson(json);

        // Assert
        expect(result.id, equals('2'));
        expect(result.currentVersion, equals('2.0.0'));
        expect(result.minimumVersion, equals('1.5.0'));
        expect(result.updateLink, equals('https://example.com/update2'));
        expect(result.appVersion, equals('2.0.0'));
      });

      test('should create VersionModel with default appVersion', () {
        // Arrange
        final json = {
          'id': '1',
          'current_version': '1.0.0',
          'minimum_version': '1.0.0',
          'update_link': 'https://example.com/update',
        };

        // Act
        final result = VersionModel.fromJson(json);

        // Assert
        expect(result.id, equals('1'));
        expect(result.currentVersion, equals('1.0.0'));
        expect(result.minimumVersion, equals('1.0.0'));
        expect(result.updateLink, equals('https://example.com/update'));
        expect(result.appVersion, equals('1.0.0'));
      });

      test('should handle string id conversion', () {
        // Arrange
        final json = {
          'id': 123,
          'current_version': '1.0.0',
          'minimum_version': '1.0.0',
          'update_link': 'https://example.com/update',
          'app_version': '1.0.0',
        };

        // Act
        final result = VersionModel.fromJson(json);

        // Assert
        expect(result.id, equals('123'));
      });
    });

    group('toJson', () {
      test('should convert VersionModel to JSON', () {
        // Act
        final result = versionModel.toJson();

        // Assert
        expect(result['id'], equals('1'));
        expect(result['current_version'], equals('1.0.0'));
        expect(result['minimum_version'], equals('1.0.0'));
        expect(result['update_link'], equals('https://example.com/update'));
        expect(result['app_version'], equals('1.0.0'));
      });

      test('should handle default appVersion in JSON', () {
        // Arrange
        const model = VersionModel(
          id: '1',
          currentVersion: '1.0.0',
          minimumVersion: '1.0.0',
          updateLink: 'https://example.com/update',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['app_version'], equals('1.0.0'));
      });

      test('should convert different VersionModel to JSON', () {
        // Arrange
        const model = VersionModel(
          id: '5',
          currentVersion: '3.0.0',
          minimumVersion: '2.0.0',
          updateLink: 'https://example.com/update3',
          appVersion: '3.0.0',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], equals('5'));
        expect(result['current_version'], equals('3.0.0'));
        expect(result['minimum_version'], equals('2.0.0'));
        expect(result['update_link'], equals('https://example.com/update3'));
        expect(result['app_version'], equals('3.0.0'));
      });
    });

    group('inheritance', () {
      test('should be instance of Version', () {
        // Assert
        expect(versionModel, isA<Version>());
      });
    });
  });
}
