import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/injector/app_injection.dart';
import '../../../features/tests/domain/entities/test_options.dart';
import '../../../features/tests/domain/requests/get_test_options_request.dart';
import '../../../features/tests/domain/usecases/get_test_options_use_case.dart';

part 'test_mode_settings_event.dart';
part 'test_mode_settings_state.dart';

class TestModeSettingsBloc extends Bloc<TestModeSettingsEvent, TestModeSettingsState> {
  final GetTestOptionsUseCase _getTestOptionsUseCase;

  TestModeSettingsBloc({GetTestOptionsUseCase? getTestOptionsUseCase})
    : _getTestOptionsUseCase = getTestOptionsUseCase ?? sl<GetTestOptionsUseCase>(),
      super(const TestModeSettingsState()) {
    on<TestModeSettingsLoadEvent>(_onLoad);
    on<TestModeSettingsUpdateModeEvent>(_onUpdateMode);
    on<TestModeSettingsUpdateCategoriesEvent>(_onUpdateCategories);
    on<TestModeSettingsToggleShowCorrectAnswerEvent>(_onToggleShowCorrectAnswer);
    on<TestModeSettingsToggleSoundEffectsEvent>(_onToggleSoundEffects);
    on<TestModeSettingsSaveEvent>(_onSave);
  }

  Future<void> _onLoad(TestModeSettingsLoadEvent event, Emitter<TestModeSettingsState> emit) async {
    emit(state.copyWith(status: TestModeSettingsStatus.loading));

    try {
      final request = GetTestOptionsRequest(unitIds: event.unitIds, lessonIds: event.lessonIds);

      final result = await _getTestOptionsUseCase.call(request);

      result.fold(
        (failure) {
          emit(state.copyWith(status: TestModeSettingsStatus.error, errorMessage: failure.message));
        },
        (response) {
          final testOptions = response.testOptions;
          final defaultMode = testOptions.defaultMode;
          final modeSettings = testOptions.getSettingsForMode(defaultMode);

          if (modeSettings != null) {
            emit(
              state.copyWith(
                status: TestModeSettingsStatus.loaded,
                testOptions: testOptions,
                selectedMode: defaultMode,
                selectedCategories: List.from(modeSettings.availableCategories),
                showCorrectAnswer: modeSettings.canToggleShowCorrectAnswer,
                soundEffectsEnabled: modeSettings.canToggleSoundEffects,
                errorMessage: null,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: TestModeSettingsStatus.error,
                errorMessage: 'Mode settings not found',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(status: TestModeSettingsStatus.error, errorMessage: e.toString()));
    }
  }

  void _onUpdateMode(TestModeSettingsUpdateModeEvent event, Emitter<TestModeSettingsState> emit) {
    if (state.isLoaded && state.testOptions != null) {
      final newModeSettings = state.testOptions!.getSettingsForMode(event.selectedMode);

      if (newModeSettings != null) {
        emit(
          state.copyWith(
            selectedMode: event.selectedMode,
            selectedCategories: List.from(newModeSettings.availableCategories),
            showCorrectAnswer: newModeSettings.canToggleShowCorrectAnswer,
            soundEffectsEnabled: newModeSettings.canToggleSoundEffects,
          ),
        );
      }
    }
  }

  void _onUpdateCategories(
    TestModeSettingsUpdateCategoriesEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    if (state.isLoaded) {
      emit(state.copyWith(selectedCategories: event.selectedCategories));
    }
  }

  void _onToggleShowCorrectAnswer(
    TestModeSettingsToggleShowCorrectAnswerEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    if (state.isLoaded) {
      emit(state.copyWith(showCorrectAnswer: event.showCorrectAnswer));
    }
  }

  void _onToggleSoundEffects(
    TestModeSettingsToggleSoundEffectsEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    if (state.isLoaded) {
      emit(state.copyWith(soundEffectsEnabled: event.soundEffectsEnabled));
    }
  }

  void _onSave(TestModeSettingsSaveEvent event, Emitter<TestModeSettingsState> emit) {
    if (state.isLoaded && state.testOptions != null && state.selectedMode != null) {
      // Get the current mode settings
      final currentModeSettings = state.testOptions!.getSettingsForMode(state.selectedMode!);

      if (currentModeSettings != null) {
        // Create updated mode settings with current user selections
        final updatedModeSettings = currentModeSettings.copyWith(
          availableCategories: state.selectedCategories,
          canToggleShowCorrectAnswer: state.showCorrectAnswer,
          canToggleSoundEffects: state.soundEffectsEnabled,
        );

        // Create updated test options with the modified mode settings
        final updatedTestOptions = state.testOptions!.copyWith(
          modeSettings: {
            ...state.testOptions!.modeSettings,
            state.selectedMode!: updatedModeSettings,
          },
          defaultMode: state.selectedMode!,
        );

        emit(
          state.copyWith(status: TestModeSettingsStatus.saved, savedOptions: updatedTestOptions),
        );
      } else {
        emit(
          state.copyWith(
            status: TestModeSettingsStatus.error,
            errorMessage: 'Failed to save: Mode settings not found',
          ),
        );
      }
    }
  }
}
