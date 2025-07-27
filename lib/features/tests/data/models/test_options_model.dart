import 'package:bac_project/features/tests/data/mappers/test_options_mapper.dart';
import 'package:bac_project/features/tests/data/models/mode_settings_model.dart';

import '../../domain/entities/test_options.dart';

class TestOptionsModel extends TestOptions {
  const TestOptionsModel({
    required super.id,
    super.unitIds,
    super.lessonIds,
    required super.modeSettings,
    required super.defaultMode,
  });

  factory TestOptionsModel.fromJson(Map<String, dynamic> json) {
    final modeSettingsJson = json['mode_settings'] as Map<String, dynamic>;
    final modeSettings = <TestMode, ModeSettings>{};

    modeSettingsJson.forEach((key, value) {
      final testMode = TestMode.values.firstWhere(
        (mode) => mode.name == key,
        orElse: () => TestMode.testing,
      );
      modeSettings[testMode] = ModeSettingsModel.fromJson(value as Map<String, dynamic>);
    });

    final defaultMode = TestMode.values.firstWhere(
      (mode) => mode.name == json['default_mode'],
      orElse: () => TestMode.testing,
    );

    return TestOptionsModel(
      id: json['id'] as String,
      unitIds: json['unit_ids'] != null ? List<String>.from(json['unit_ids'] as List) : null,
      lessonIds: json['lesson_ids'] != null ? List<String>.from(json['lesson_ids'] as List) : null,
      modeSettings: modeSettings,
      defaultMode: defaultMode,
    );
  }

  Map<String, dynamic> toJson() {
    final modeSettingsJson = <String, dynamic>{};
    modeSettings.forEach((key, value) {
      modeSettingsJson[key.name] = (value as ModeSettingsModel).toJson();
    });

    return {
      'id': id,
      'unit_ids': unitIds,
      'lesson_ids': lessonIds,
      'mode_settings': modeSettingsJson,
      'default_mode': defaultMode.name,
    };
  }


  @override
  TestOptionsModel copyWith({
    String? id,
    List<String>? unitIds,
    List<String>? lessonIds,
    Map<TestMode, ModeSettings>? modeSettings,
    TestMode? defaultMode,
  }) {
    return TestOptionsModel(
      id: id ?? this.id,
      unitIds: unitIds ?? this.unitIds,
      lessonIds: lessonIds ?? this.lessonIds,
      modeSettings: modeSettings ?? this.modeSettings,
      defaultMode: defaultMode ?? this.defaultMode,
    );
  }

  @override
  String toString() =>
      'TestOptionsModel(id: $id, unitIds: $unitIds, lessonIds: $lessonIds, modeSettings: $modeSettings, defaultMode: $defaultMode)';
}
