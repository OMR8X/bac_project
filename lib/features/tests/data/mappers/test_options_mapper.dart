import 'package:bac_project/features/tests/data/models/mode_settings_model.dart';

import '../models/test_options_model.dart';
import '../../domain/entities/test_options.dart';

extension ModeSettingsModelExtension on ModeSettingsModel {
  ModeSettings toEntity() {
    return ModeSettings(
      canSelectCategories: canSelectCategories,
      canSelectQuestionCount: canSelectQuestionCount,
      canToggleShowCorrectAnswer: canToggleShowCorrectAnswer,
      canToggleSoundEffects: canToggleSoundEffects,
      availableCategories: availableCategories,
    );
  }
}

extension ModeSettingsEntityExtension on ModeSettings {
  ModeSettingsModel toModel() {
    return ModeSettingsModel(
      canSelectCategories: canSelectCategories,
      canSelectQuestionCount: canSelectQuestionCount,
      canToggleShowCorrectAnswer: canToggleShowCorrectAnswer,
      canToggleSoundEffects: canToggleSoundEffects,
      availableCategories: availableCategories,
    );
  }
}

extension TestOptionsModelExtension on TestOptionsModel {
  TestOptions toEntity() {
    return TestOptions(
      id: id,
      unitIds: unitIds,
      lessonIds: lessonIds,
      modeSettings: modeSettings,
      defaultMode: defaultMode,
    );
  }
}

extension TestOptionsEntityExtension on TestOptions {
  TestOptionsModel toModel() {
    final modelModeSettings = <TestMode, ModeSettingsModel>{};

    modeSettings.forEach((key, value) {
      modelModeSettings[key] = value.toModel();
    });

    return TestOptionsModel(
      id: id,
      unitIds: unitIds,
      lessonIds: lessonIds,
      modeSettings: modelModeSettings,
      defaultMode: defaultMode,
    );
  }
}
