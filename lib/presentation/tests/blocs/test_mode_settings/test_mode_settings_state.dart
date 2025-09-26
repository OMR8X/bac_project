part of 'test_mode_settings_bloc.dart';

enum TestModeSettingsStatus {
  initial,
  loading,
  loaded,
  error,
  saved,
  fetchingQuestions,
  noQuestions,
}

class TestModeSettingsState extends Equatable {
  ///
  final Failure? failure;
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
    this.failure,
    this.questions = const [],
  });

  TestModeSettingsState copyWith({
    TestOptions? testOptions,
    TestModeSettingsStatus? status,
    Failure? failure,
    List<Question>? questions,
  }) {
    return TestModeSettingsState(
      testOptions: testOptions ?? this.testOptions,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [testOptions, status, failure, questions];
}
