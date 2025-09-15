import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/app_settings_model.dart';
import 'package:bac_project/features/settings/data/models/version_model.dart';
import 'package:bac_project/features/settings/data/models/motivational_quote_model.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';
import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/auth/data/models/governorate_model.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

void main() {
  group('AppSettingsModel', () {
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

      appSettingsModel = AppSettingsModel(
        userData: testUserData,
        motivationalQuote: testQuote,
        sections: testSections,
        governorates: testGovernorates,
        version: testVersion,
        categories: testCategories,
      );
    });

    group('fromJson', () {
      test('should create AppSettingsModel from valid JSON', () {
        // Arrange
        final json = {
          'user_data': {
            'uuid': 'user123',
            'name': 'Test User',
            'email': 'test@example.com',
            'section_id': '1',
            'governorate_id': '1',
          },
          'motivational_quote': {
            'quote': 'Test quote',
            'author': 'Test Author',
            'date': '2023-01-01T10:00:00Z',
          },
          'sections': [
            {'id': 1, 'title': 'Section 1'},
            {'id': 2, 'title': 'Section 2'},
          ],
          'governorates': [
            {'id': 1, 'title': 'Governorate 1'},
            {'id': 2, 'title': 'Governorate 2'},
          ],
          'categories': [
            {'id': 1, 'title': 'Math', 'questions_count': 50},
            {'id': 2, 'title': 'Science', 'questions_count': 75},
          ],
          'version': {
            'id': '1',
            'current_version': '1.0.0',
            'minimum_version': '1.0.0',
            'update_link': 'https://example.com/update',
            'app_version': '1.0.0',
          },
        };

        // Act
        final result = AppSettingsModel.fromJson(json);

        // Assert
        expect(result.userData, isNotNull);
        expect(result.motivationalQuote, isNotNull);
        expect(result.sections.length, equals(2));
        expect(result.governorates.length, equals(2));
        expect(result.categories.length, equals(2));
        expect(result.version, isNotNull);
      });

      test('should create AppSettingsModel from JSON with null optional fields', () {
        // Arrange
        final json = {
          'sections': [],
          'governorates': [],
          'categories': [],
          'version': {
            'id': '1',
            'current_version': '1.0.0',
            'minimum_version': '1.0.0',
            'update_link': 'https://example.com/update',
            'app_version': '1.0.0',
          },
        };

        // Act
        final result = AppSettingsModel.fromJson(json);

        // Assert
        expect(result.userData, isNull);
        expect(result.motivationalQuote, isNull);
        expect(result.sections, isEmpty);
        expect(result.governorates, isEmpty);
        expect(result.categories, isEmpty);
        expect(result.version, isNotNull);
      });

      test('should handle null lists in JSON', () {
        // Arrange
        final json = {
          'sections': null,
          'governorates': null,
          'categories': null,
          'version': {
            'id': '1',
            'current_version': '1.0.0',
            'minimum_version': '1.0.0',
            'update_link': 'https://example.com/update',
            'app_version': '1.0.0',
          },
        };

        // Act
        final result = AppSettingsModel.fromJson(json);

        // Assert
        expect(result.sections, isEmpty);
        expect(result.governorates, isEmpty);
        expect(result.categories, isEmpty);
      });
    });

    group('toJson', () {
      test('should convert AppSettingsModel to JSON', () {
        // Act
        final result = appSettingsModel.toJson();

        // Assert
        expect(result['sections'], isA<List>());
        expect(result['governorates'], isA<List>());
        expect(result['categories'], isA<List>());
        expect(result['version'], isA<Map<String, dynamic>>());
        expect(result['motivational_quote'], isA<Map<String, dynamic>>());
      });

      test('should handle null userData in JSON', () {
        // Arrange
        final model = AppSettingsModel(
          userData: null,
          motivationalQuote: testQuote,
          sections: testSections,
          governorates: testGovernorates,
          version: testVersion,
          categories: testCategories,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['sections'], isA<List>());
        expect(result['governorates'], isA<List>());
        expect(result['categories'], isA<List>());
        expect(result['version'], isA<Map<String, dynamic>>());
        expect(result['motivational_quote'], isA<Map<String, dynamic>>());
      });

      test('should handle null motivationalQuote in JSON', () {
        // Arrange
        final model = AppSettingsModel(
          userData: testUserData,
          motivationalQuote: null,
          sections: testSections,
          governorates: testGovernorates,
          version: testVersion,
          categories: testCategories,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['sections'], isA<List>());
        expect(result['governorates'], isA<List>());
        expect(result['categories'], isA<List>());
        expect(result['version'], isA<Map<String, dynamic>>());
        expect(result['motivational_quote'], isNull);
      });
    });

    group('inheritance', () {
      test('should be instance of AppSettings', () {
        // Assert
        expect(appSettingsModel, isA<AppSettings>());
      });
    });
  });
}
