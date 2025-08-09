import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/test_options_model.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/data/mappers/test_options_mapper.dart';

void main() {
  group('ModeSettingsMapper', () {
    const testModeSettingsModel = ModeSettingsModel(
      canSelectCategories: true,
      canSelectQuestionCount: false,
      canToggleShowCorrectAnswer: true,
      canToggleSoundEffects: false,
      availableCategories: ['الجبر', 'الهندسة', 'التفاضل والتكامل'],
      availableQuestionCounts: [10, 20, 30],
      defaultQuestionCount: 20,
    );

    const testModeSettings = ModeSettings(
      canSelectCategories: true,
      canSelectQuestionCount: false,
      canToggleShowCorrectAnswer: true,
      canToggleSoundEffects: false,
      availableCategories: ['الجبر', 'الهندسة', 'التفاضل والتكامل'],
      availableQuestionCounts: [10, 20, 30],
      defaultQuestionCount: 20,
    );

    test('should convert ModeSettingsModel to ModeSettings entity', () {
      // act
      final result = testModeSettingsModel.toEntity();

      // assert
      expect(result, equals(testModeSettings));
      expect(
        result.canSelectCategories,
        equals(testModeSettingsModel.canSelectCategories),
      );
      expect(
        result.canSelectQuestionCount,
        equals(testModeSettingsModel.canSelectQuestionCount),
      );
      expect(
        result.canToggleShowCorrectAnswer,
        equals(testModeSettingsModel.canToggleShowCorrectAnswer),
      );
      expect(
        result.canToggleSoundEffects,
        equals(testModeSettingsModel.canToggleSoundEffects),
      );
      expect(
        result.availableCategories,
        equals(testModeSettingsModel.availableCategories),
      );
      expect(
        result.availableQuestionCounts,
        equals(testModeSettingsModel.availableQuestionCounts),
      );
      expect(
        result.defaultQuestionCount,
        equals(testModeSettingsModel.defaultQuestionCount),
      );
    });

    test('should convert ModeSettings entity to ModeSettingsModel', () {
      // act
      final result = testModeSettings.toModel();

      // assert
      expect(result, equals(testModeSettingsModel));
      expect(
        result.canSelectCategories,
        equals(testModeSettings.canSelectCategories),
      );
      expect(
        result.canSelectQuestionCount,
        equals(testModeSettings.canSelectQuestionCount),
      );
      expect(
        result.canToggleShowCorrectAnswer,
        equals(testModeSettings.canToggleShowCorrectAnswer),
      );
      expect(
        result.canToggleSoundEffects,
        equals(testModeSettings.canToggleSoundEffects),
      );
      expect(
        result.availableCategories,
        equals(testModeSettings.availableCategories),
      );
      expect(
        result.availableQuestionCounts,
        equals(testModeSettings.availableQuestionCounts),
      );
      expect(
        result.defaultQuestionCount,
        equals(testModeSettings.defaultQuestionCount),
      );
    });

    test('should maintain data integrity during round-trip conversion', () {
      // act
      final entityFromModel = testModeSettingsModel.toEntity();
      final modelFromEntity = entityFromModel.toModel();

      // assert
      expect(modelFromEntity, equals(testModeSettingsModel));
    });

    test('should handle empty categories list', () {
      // arrange
      const emptyModel = ModeSettingsModel(
        canSelectCategories: false,
        canSelectQuestionCount: true,
        canToggleShowCorrectAnswer: false,
        canToggleSoundEffects: true,
        availableCategories: [],
        availableQuestionCounts: [5],
        defaultQuestionCount: 5,
      );

      // act
      final entity = emptyModel.toEntity();
      final backToModel = entity.toModel();

      // assert
      expect(entity.availableCategories, isEmpty);
      expect(backToModel.availableCategories, isEmpty);
      expect(backToModel, equals(emptyModel));
    });

    test('should handle single item collections', () {
      // arrange
      const singleItemModel = ModeSettingsModel(
        canSelectCategories: true,
        canSelectQuestionCount: true,
        canToggleShowCorrectAnswer: true,
        canToggleSoundEffects: true,
        availableCategories: ['الرياضيات'],
        availableQuestionCounts: [15],
        defaultQuestionCount: 15,
      );

      // act
      final entity = singleItemModel.toEntity();
      final backToModel = entity.toModel();

      // assert
      expect(entity.availableCategories.length, equals(1));
      expect(entity.availableQuestionCounts.length, equals(1));
      expect(backToModel, equals(singleItemModel));
    });
  });

  group('TestOptionsMapper', () {
    const testModeSettingsMap = {
      'testing': ModeSettingsModel(
        canSelectCategories: true,
        canSelectQuestionCount: false,
        canToggleShowCorrectAnswer: false,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة'],
        availableQuestionCounts: [20],
        defaultQuestionCount: 20,
      ),
      'exploring': ModeSettingsModel(
        canSelectCategories: true,
        canSelectQuestionCount: true,
        canToggleShowCorrectAnswer: true,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة', 'التفاضل والتكامل'],
        availableQuestionCounts: [10, 20, 30],
        defaultQuestionCount: 10,
      ),
    };

    const testEntityModeSettingsMap = {
      TestMode.testing: ModeSettings(
        canSelectCategories: true,
        canSelectQuestionCount: false,
        canToggleShowCorrectAnswer: false,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة'],
        availableQuestionCounts: [20],
        defaultQuestionCount: 20,
      ),
      TestMode.exploring: ModeSettings(
        canSelectCategories: true,
        canSelectQuestionCount: true,
        canToggleShowCorrectAnswer: true,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة', 'التفاضل والتكامل'],
        availableQuestionCounts: [10, 20, 30],
        defaultQuestionCount: 10,
      ),
    };

    const testTestOptionsModel = TestOptionsModel(
      id: 'test_options',
      unitId: '1',
      lessonId: null,
      modeSettings: testModeSettingsMap,
      defaultMode: 'exploring',
    );

    const testTestOptions = TestOptions(
      id: 'test_options',
      unitId: '1',
      lessonId: null,
      modeSettings: testEntityModeSettingsMap,
      defaultMode: TestMode.exploring,
    );

    test('should convert TestOptionsModel to TestOptions entity', () {
      // act
      final result = testTestOptionsModel.toEntity();

      // assert
      expect(result.id, equals(testTestOptions.id));
      expect(result.unitId, equals(testTestOptions.unitId));
      expect(result.lessonId, equals(testTestOptions.lessonId));
      expect(result.defaultMode, equals(testTestOptions.defaultMode));
      expect(
        result.modeSettings.length,
        equals(testTestOptions.modeSettings.length),
      );
      expect(result.modeSettings.containsKey(TestMode.testing), isTrue);
      expect(result.modeSettings.containsKey(TestMode.exploring), isTrue);
    });

    test('should convert TestOptions entity to TestOptionsModel', () {
      // act
      final result = testTestOptions.toModel();

      // assert
      expect(result.id, equals(testTestOptionsModel.id));
      expect(result.unitId, equals(testTestOptionsModel.unitId));
      expect(result.lessonId, equals(testTestOptionsModel.lessonId));
      expect(result.defaultMode, equals(testTestOptionsModel.defaultMode));
      expect(
        result.modeSettings.length,
        equals(testTestOptionsModel.modeSettings.length),
      );
      expect(result.modeSettings.containsKey('testing'), isTrue);
      expect(result.modeSettings.containsKey('exploring'), isTrue);
    });

    test('should maintain data integrity during round-trip conversion', () {
      // act
      final entityFromModel = testTestOptionsModel.toEntity();
      final modelFromEntity = entityFromModel.toModel();

      // assert
      expect(modelFromEntity.id, equals(testTestOptionsModel.id));
      expect(modelFromEntity.unitId, equals(testTestOptionsModel.unitId));
      expect(modelFromEntity.lessonId, equals(testTestOptionsModel.lessonId));
      expect(
        modelFromEntity.defaultMode,
        equals(testTestOptionsModel.defaultMode),
      );
      expect(
        modelFromEntity.modeSettings.length,
        equals(testTestOptionsModel.modeSettings.length),
      );
    });

    test('should handle TestOptions with null unitId and lessonId', () {
      // arrange
      const nullableModel = TestOptionsModel(
        id: 'default_options',
        unitId: null,
        lessonId: null,
        modeSettings: testModeSettingsMap,
        defaultMode: 'testing',
      );

      const nullableEntity = TestOptions(
        id: 'default_options',
        unitId: null,
        lessonId: null,
        modeSettings: testEntityModeSettingsMap,
        defaultMode: TestMode.testing,
      );

      // act
      final entityFromModel = nullableModel.toEntity();
      final modelFromEntity = nullableEntity.toModel();

      // assert
      expect(entityFromModel.unitId, isNull);
      expect(entityFromModel.lessonId, isNull);
      expect(entityFromModel.defaultMode, equals(TestMode.testing));
      expect(modelFromEntity.unitId, isNull);
      expect(modelFromEntity.lessonId, isNull);
      expect(modelFromEntity.defaultMode, equals('testing'));
    });

    test('should handle TestOptions with lessonId but no unitId', () {
      // arrange
      const lessonModel = TestOptionsModel(
        id: 'lesson_5_options',
        unitId: null,
        lessonId: '5',
        modeSettings: testModeSettingsMap,
        defaultMode: 'exploring',
      );

      // act
      final entity = lessonModel.toEntity();
      final backToModel = entity.toModel();

      // assert
      expect(entity.unitId, isNull);
      expect(entity.lessonId, equals('5'));
      expect(entity.defaultMode, equals(TestMode.exploring));
      expect(backToModel.unitId, isNull);
      expect(backToModel.lessonId, equals('5'));
      expect(backToModel.defaultMode, equals('exploring'));
    });

    test('should correctly map mode settings during conversion', () {
      // act
      final entity = testTestOptionsModel.toEntity();

      // assert
      final testingSettings = entity.modeSettings[TestMode.testing]!;
      final exploringSettings = entity.modeSettings[TestMode.exploring]!;

      expect(testingSettings.canSelectCategories, isTrue);
      expect(testingSettings.canSelectQuestionCount, isFalse);
      expect(testingSettings.defaultQuestionCount, equals(20));

      expect(exploringSettings.canSelectCategories, isTrue);
      expect(exploringSettings.canSelectQuestionCount, isTrue);
      expect(exploringSettings.defaultQuestionCount, equals(10));
    });

    test('should preserve mode settings structure during conversion', () {
      // act
      final model = testTestOptions.toModel();

      // assert
      final testingSettings = model.modeSettings['testing']!;
      final exploringSettings = model.modeSettings['exploring']!;

      expect(testingSettings.availableCategories.length, equals(2));
      expect(testingSettings.availableQuestionCounts.length, equals(1));

      expect(exploringSettings.availableCategories.length, equals(3));
      expect(exploringSettings.availableQuestionCounts.length, equals(3));
    });

    test('should handle empty mode settings map', () {
      // arrange
      const emptyModel = TestOptionsModel(
        id: 'empty_options',
        unitId: null,
        lessonId: null,
        modeSettings: <String, ModeSettingsModel>{},
        defaultMode: 'testing',
      );

      const emptyEntity = TestOptions(
        id: 'empty_options',
        unitId: null,
        lessonId: null,
        modeSettings: <TestMode, ModeSettings>{},
        defaultMode: TestMode.testing,
      );

      // act
      final entityFromModel = emptyModel.toEntity();
      final modelFromEntity = emptyEntity.toModel();

      // assert
      expect(entityFromModel.modeSettings, isEmpty);
      expect(modelFromEntity.modeSettings, isEmpty);
    });
  });
}
