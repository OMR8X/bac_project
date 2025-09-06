part of 'test_mode_settings_bloc.dart';

enum TestModeSettingsStatus { initial, loading, loaded, error, saved, fetchingQuestions }

class TestModeSettingsState extends Equatable {
  ///
  final String? message;
  final TestModeSettingsStatus status;

  ///
  final List<Question> questions;
  final TestOptions testOptions;

  ///
  const TestModeSettingsState({
    this.testOptions = const TestOptions(
      selectedMode: TestMode.exploring,
      selectedCategories: [],
      showTrueAnswers: false,
      enableSounds: true,
    ),
    this.status = TestModeSettingsStatus.initial,
    this.message,
    this.questions = const [],
  });

  TestModeSettingsState copyWith({
    TestOptions? testOptions,
    TestModeSettingsStatus? status,
    String? message,
    List<Question>? questions,
  }) {
    return TestModeSettingsState(
      testOptions: testOptions ?? this.testOptions,
      status: status ?? this.status,
      message: message ?? this.message,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [testOptions, status, message, questions];
}
