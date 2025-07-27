import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

enum TestMode { testing, exploring }

class ModeSettings {
  final bool canSelectCategories;
  final bool canSelectQuestionCount;
  final bool canToggleShowCorrectAnswer;
  final bool canToggleSoundEffects;
  final List<QuestionCategory> availableCategories;
  final List<Lesson>? availableLessons;

  const ModeSettings({
    required this.canSelectCategories,
    required this.canSelectQuestionCount,
    required this.canToggleShowCorrectAnswer,
    required this.canToggleSoundEffects,
    required this.availableCategories,
    this.availableLessons,
  });

  factory ModeSettings.empty() {
    return ModeSettings(
      canSelectCategories: false,
      canSelectQuestionCount: false,
      canToggleShowCorrectAnswer: false,
      canToggleSoundEffects: false,
      availableCategories: [],
      availableLessons: [],
    );
  }

  ModeSettings copyWith({
    bool? canSelectCategories,
    bool? canSelectQuestionCount,
    bool? canToggleShowCorrectAnswer,
    bool? canToggleSoundEffects,
    List<QuestionCategory>? availableCategories,
    List<Lesson>? availableLessons,
  }) {
    return ModeSettings(
      canSelectCategories: canSelectCategories ?? this.canSelectCategories,
      canSelectQuestionCount: canSelectQuestionCount ?? this.canSelectQuestionCount,
      canToggleShowCorrectAnswer: canToggleShowCorrectAnswer ?? this.canToggleShowCorrectAnswer,
      canToggleSoundEffects: canToggleSoundEffects ?? this.canToggleSoundEffects,
      availableCategories: availableCategories ?? this.availableCategories,
      availableLessons: availableLessons ?? this.availableLessons,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ModeSettings &&
        other.canSelectCategories == canSelectCategories &&
        other.canSelectQuestionCount == canSelectQuestionCount &&
        other.canToggleShowCorrectAnswer == canToggleShowCorrectAnswer &&
        other.canToggleSoundEffects == canToggleSoundEffects &&
        other.availableCategories == availableCategories &&
        other.availableLessons == availableLessons;
  }

  @override
  String toString() =>
      'ModeSettings(canSelectCategories: $canSelectCategories, canSelectQuestionCount: $canSelectQuestionCount, canToggleShowCorrectAnswer: $canToggleShowCorrectAnswer, canToggleSoundEffects: $canToggleSoundEffects, availableCategories: $availableCategories, availableLessons: $availableLessons)';
}

class TestOptions {
  final String id;
  final List<String>? unitIds;
  final List<String>? lessonIds;
  final Map<TestMode, ModeSettings> modeSettings;
  final TestMode defaultMode;

  const TestOptions({
    required this.id,
    this.unitIds,
    this.lessonIds,
    required this.modeSettings,
    required this.defaultMode,
  });

  ModeSettings? getSettingsForMode(TestMode mode) {
    return modeSettings[mode];
  }

  List<TestMode> get availableModes => modeSettings.keys.toList();

  factory TestOptions.empty() {
    return TestOptions(id: '', modeSettings: {}, defaultMode: TestMode.testing);
  }

  TestOptions copyWith({
    String? id,
    List<String>? unitIds,
    List<String>? lessonIds,
    Map<TestMode, ModeSettings>? modeSettings,
    TestMode? defaultMode,
  }) {
    return TestOptions(
      id: id ?? this.id,
      unitIds: unitIds ?? this.unitIds,
      lessonIds: lessonIds ?? this.lessonIds,
      modeSettings: modeSettings ?? this.modeSettings,
      defaultMode: defaultMode ?? this.defaultMode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestOptions &&
        other.id == id &&
        other.unitIds == unitIds &&
        other.lessonIds == lessonIds &&
        other.modeSettings == modeSettings &&
        other.defaultMode == defaultMode;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      unitIds.hashCode ^
      lessonIds.hashCode ^
      modeSettings.hashCode ^
      defaultMode.hashCode;

  @override
  String toString() =>
      'TestOptions(id: $id, unitIds: $unitIds, lessonIds: $lessonIds, modeSettings: $modeSettings, defaultMode: $defaultMode)';
}
