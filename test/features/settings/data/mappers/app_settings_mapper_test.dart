import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/app_settings_model.dart';
import 'package:bac_project/features/settings/data/mappers/app_settings_mapper.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/settings/data/models/motivational_quote_model.dart';
import 'package:bac_project/features/settings/data/models/version_model.dart';

void main() {
  group('AppSettingsMapper', () {
    late AppSettings appSettingsEntity;
    late AppSettingsModel appSettingsModel;
    late UserData testUserData;
    late MotivationalQuote testQuote;
    late List<Section> testSections;
    late List<Governorate> testGovernorates;
    late Version testVersion;
    late List<QuestionCategory> testCategories;

    setUp(() {
      testUserData = UserData(
        uuid: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        sectionId: '1',
        governorateId: '1',
      );

      testQuote = MotivationalQuote(
        quote: 'Test quote',
        author: 'Test Author',
        date: DateTime.parse('2023-01-01T10:00:00Z'),
      );

      testSections = [
        const Section(id: 1, title: 'Section 1'),
        const Section(id: 2, title: 'Section 2'),
      ];

      testGovernorates = [
        const Governorate(id: 1, title: 'Governorate 1'),
        const Governorate(id: 2, title: 'Governorate 2'),
      ];

      testVersion = const Version(
        id: '1',
        currentVersion: '1.0.0',
        minimumVersion: '1.0.0',
        updateLink: 'https://example.com/update',
        appVersion: '1.0.0',
      );

      testCategories = [
        const QuestionCategory(id: 1, title: 'Math', questionsCount: 50),
        const QuestionCategory(id: 2, title: 'Science', questionsCount: 75),
      ];

      appSettingsEntity = AppSettings(
        userData: testUserData,
        motivationalQuote: testQuote,
        sections: testSections,
        governorates: testGovernorates,
        version: testVersion,
        categories: testCategories,
      );

      appSettingsModel = AppSettingsModel(
        userData: testUserData,
        motivationalQuote: testQuote,
        sections: testSections,
        governorates: testGovernorates,
        version: testVersion,
        categories: testCategories,
      );
    });

    group('AppSettingsMapper.toModel', () {
      test('should convert AppSettings entity to AppSettingsModel', () {
        // Act
        final result = appSettingsEntity.toModel;

        // Assert
        expect(result, isA<AppSettingsModel>());
        expect(result.userData, equals(appSettingsEntity.userData));
        expect(result.motivationalQuote, isA<MotivationalQuote>());
        expect(result.motivationalQuote?.quote, equals(appSettingsEntity.motivationalQuote?.quote));
        expect(
          result.motivationalQuote?.author,
          equals(appSettingsEntity.motivationalQuote?.author),
        );
        expect(result.sections, equals(appSettingsEntity.sections));
        expect(result.governorates, equals(appSettingsEntity.governorates));
        expect(result.version, isA<Version>());
        expect(result.version.id, equals(appSettingsEntity.version.id));
        expect(result.version.currentVersion, equals(appSettingsEntity.version.currentVersion));
        expect(result.categories, equals(appSettingsEntity.categories));
      });

      test('should handle null userData', () {
        // Arrange
        final entity = AppSettings(
          userData: null,
          motivationalQuote: null,
          sections: [],
          governorates: [],
          version: testVersion,
          categories: [],
        );

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.userData, isNull);
        expect(result.motivationalQuote, isNull);
        expect(result.sections, isEmpty);
        expect(result.governorates, isEmpty);
        expect(result.version, isA<Version>());
        expect(result.categories, isEmpty);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = appSettingsEntity.toModel;

        // Assert
        expect(result.userData, equals(testUserData));
        expect(result.motivationalQuote, isA<MotivationalQuote>());
        expect(result.motivationalQuote?.quote, equals(testQuote.quote));
        expect(result.motivationalQuote?.author, equals(testQuote.author));
        expect(result.sections.length, equals(2));
        expect(result.governorates.length, equals(2));
        expect(result.version, isA<Version>());
        expect(result.version.id, equals(testVersion.id));
        expect(result.version.currentVersion, equals(testVersion.currentVersion));
        expect(result.categories.length, equals(2));
      });
    });

    group('AppSettingsModelMapper.toEntity', () {
      test('should convert AppSettingsModel to AppSettings entity', () {
        // Act
        final result = appSettingsModel.toEntity;

        // Assert
        expect(result, isA<AppSettings>());
        expect(result.userData, equals(appSettingsModel.userData));
        expect(result.motivationalQuote, equals(appSettingsModel.motivationalQuote));
        expect(result.sections, equals(appSettingsModel.sections));
        expect(result.governorates, equals(appSettingsModel.governorates));
        expect(result.version, equals(appSettingsModel.version));
        expect(result.categories, equals(appSettingsModel.categories));
      });

      test('should handle null userData', () {
        // Arrange
        final model = AppSettingsModel(
          userData: null,
          motivationalQuote: null,
          sections: [],
          governorates: [],
          version: testVersion,
          categories: [],
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.userData, isNull);
        expect(result.motivationalQuote, isNull);
        expect(result.sections, isEmpty);
        expect(result.governorates, isEmpty);
        expect(result.version, isA<Version>());
        expect(result.categories, isEmpty);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = appSettingsModel.toEntity;

        // Assert
        expect(result.userData, equals(testUserData));
        expect(result.motivationalQuote, isA<MotivationalQuote>());
        expect(result.motivationalQuote?.quote, equals(testQuote.quote));
        expect(result.motivationalQuote?.author, equals(testQuote.author));
        expect(result.sections.length, equals(2));
        expect(result.governorates.length, equals(2));
        expect(result.version, isA<Version>());
        expect(result.version.id, equals(testVersion.id));
        expect(result.version.currentVersion, equals(testVersion.currentVersion));
        expect(result.categories.length, equals(2));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = appSettingsModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.userData, equals(appSettingsModel.userData));
        expect(backToModel.motivationalQuote, isA<MotivationalQuoteModel>());
        expect(
          backToModel.motivationalQuote?.quote,
          equals(appSettingsModel.motivationalQuote?.quote),
        );
        expect(
          backToModel.motivationalQuote?.author,
          equals(appSettingsModel.motivationalQuote?.author),
        );
        expect(backToModel.sections, equals(appSettingsModel.sections));
        expect(backToModel.governorates, equals(appSettingsModel.governorates));
        expect(backToModel.version, isA<VersionModel>());
        expect(backToModel.version.id, equals(testVersion.id));
        expect(backToModel.version.currentVersion, equals(testVersion.currentVersion));
        expect(backToModel.categories, equals(appSettingsModel.categories));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = appSettingsEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.userData, equals(appSettingsEntity.userData));
        expect(backToEntity.motivationalQuote, isA<MotivationalQuote>());
        expect(
          backToEntity.motivationalQuote?.quote,
          equals(appSettingsEntity.motivationalQuote?.quote),
        );
        expect(
          backToEntity.motivationalQuote?.author,
          equals(appSettingsEntity.motivationalQuote?.author),
        );
        expect(backToEntity.sections, equals(appSettingsEntity.sections));
        expect(backToEntity.governorates, equals(appSettingsEntity.governorates));
        expect(backToEntity.version, isA<Version>());
        expect(backToEntity.version.id, equals(appSettingsEntity.version.id));
        expect(
          backToEntity.version.currentVersion,
          equals(appSettingsEntity.version.currentVersion),
        );
        expect(backToEntity.categories, equals(appSettingsEntity.categories));
      });

      test('should handle null values in round-trip conversion', () {
        // Arrange
        final model = AppSettingsModel(
          userData: null,
          motivationalQuote: null,
          sections: [],
          governorates: [],
          version: testVersion,
          categories: [],
        );

        // Act
        final entity = model.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.userData, isNull);
        expect(backToModel.motivationalQuote, isNull);
        expect(backToModel.sections, isEmpty);
        expect(backToModel.governorates, isEmpty);
        expect(backToModel.version, isA<VersionModel>());
        expect(backToModel.version.id, equals(testVersion.id));
        expect(backToModel.version.currentVersion, equals(testVersion.currentVersion));
        expect(backToModel.categories, isEmpty);
      });
    });
  });
}
