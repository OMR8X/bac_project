part of 'test_mode_settings_bloc.dart';

sealed class TestModeSettingsEvent extends Equatable {
  const TestModeSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class TestModeSettingsLoadEvent extends TestModeSettingsEvent {
  final List<String>? unitIds;
  final List<String>? lessonIds;

  const TestModeSettingsLoadEvent({this.unitIds, this.lessonIds});

  @override
  List<Object?> get props => [unitIds, lessonIds];
}

final class TestModeSettingsUpdateModeEvent extends TestModeSettingsEvent {
  final TestMode selectedMode;

  const TestModeSettingsUpdateModeEvent({required this.selectedMode});

  @override
  List<Object> get props => [selectedMode];
}

final class TestModeSettingsUpdateCategoriesEvent extends TestModeSettingsEvent {
  final List<QuestionCategory> selectedCategories;

  const TestModeSettingsUpdateCategoriesEvent({required this.selectedCategories});

  @override
  List<Object> get props => [selectedCategories];
}

final class TestModeSettingsToggleShowCorrectAnswerEvent extends TestModeSettingsEvent {
  final bool showCorrectAnswer;

  const TestModeSettingsToggleShowCorrectAnswerEvent({required this.showCorrectAnswer});

  @override
  List<Object> get props => [showCorrectAnswer];
}

final class TestModeSettingsToggleSoundEffectsEvent extends TestModeSettingsEvent {
  final bool soundEffectsEnabled;

  const TestModeSettingsToggleSoundEffectsEvent({required this.soundEffectsEnabled});

  @override
  List<Object> get props => [soundEffectsEnabled];
}

final class TestModeSettingsSaveEvent extends TestModeSettingsEvent {
  const TestModeSettingsSaveEvent();
}
