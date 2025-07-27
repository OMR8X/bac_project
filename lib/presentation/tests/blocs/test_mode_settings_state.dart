part of 'test_mode_settings_bloc.dart';

enum TestModeSettingsStatus { initial, loading, loaded, error, saved }

class TestModeSettingsState extends Equatable {
  final TestModeSettingsStatus status;
  final TestOptions? testOptions;
  final TestMode? selectedMode;
  final List<QuestionCategory> selectedCategories;
  final bool showCorrectAnswer;
  final bool soundEffectsEnabled;
  final String? errorMessage;
  final TestOptions? savedOptions;

  const TestModeSettingsState({
    this.status = TestModeSettingsStatus.initial,
    this.testOptions,
    this.selectedMode,
    this.selectedCategories = const [],
    this.showCorrectAnswer = false,
    this.soundEffectsEnabled = false,
    this.errorMessage,
    this.savedOptions,
  });

  TestModeSettingsState copyWith({
    TestModeSettingsStatus? status,
    TestOptions? testOptions,
    TestMode? selectedMode,
    List<QuestionCategory>? selectedCategories,
    bool? showCorrectAnswer,
    bool? soundEffectsEnabled,
    String? errorMessage,
    TestOptions? savedOptions,
  }) {
    return TestModeSettingsState(
      status: status ?? this.status,
      testOptions: testOptions ?? this.testOptions,
      selectedMode: selectedMode ?? this.selectedMode,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      showCorrectAnswer: showCorrectAnswer ?? this.showCorrectAnswer,
      soundEffectsEnabled: soundEffectsEnabled ?? this.soundEffectsEnabled,
      errorMessage: errorMessage,
      savedOptions: savedOptions ?? this.savedOptions,
    );
  }

  // Convenience getters for easier state checking
  bool get isInitial => status == TestModeSettingsStatus.initial;
  bool get isLoading => status == TestModeSettingsStatus.loading;
  bool get isLoaded => status == TestModeSettingsStatus.loaded;
  bool get isError => status == TestModeSettingsStatus.error;
  bool get isSaved => status == TestModeSettingsStatus.saved;

  @override
  List<Object?> get props => [
    status,
    testOptions,
    selectedMode,
    selectedCategories,
    showCorrectAnswer,
    soundEffectsEnabled,
    errorMessage,
    savedOptions,
  ];
}
