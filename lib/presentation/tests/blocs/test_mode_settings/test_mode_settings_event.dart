part of 'test_mode_settings_bloc.dart';

sealed class TestModeSettingsEvent extends Equatable {
  const TestModeSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class TestModeSettingsLoadEvent extends TestModeSettingsEvent {
  final List<int>? unitIds;
  final List<int>? lessonIds;

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

final class TestModeSettingsSubmitEvent extends TestModeSettingsEvent {
  const TestModeSettingsSubmitEvent();

  @override
  List<Object> get props => [];
}

final class TestModeSettingsUpdateCategoriesEvent extends TestModeSettingsEvent {
  final List<QuestionCategory> categories;

  const TestModeSettingsUpdateCategoriesEvent({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class TestModeSettingsUpdateQuestionsCountEvent extends TestModeSettingsEvent {
  final int questionsCount;

  const TestModeSettingsUpdateQuestionsCountEvent({required this.questionsCount});

  @override
  List<Object> get props => [questionsCount];
}

final class TestModeSettingsUpdateShowTrueAnswersEvent extends TestModeSettingsEvent {
  final bool showTrueAnswers;

  const TestModeSettingsUpdateShowTrueAnswersEvent({required this.showTrueAnswers});

  @override
  List<Object> get props => [showTrueAnswers];
}

final class TestModeSettingsUpdateEnableSoundsEvent extends TestModeSettingsEvent {
  final bool enableSounds;

  const TestModeSettingsUpdateEnableSoundsEvent({required this.enableSounds});

  @override
  List<Object> get props => [enableSounds];
}