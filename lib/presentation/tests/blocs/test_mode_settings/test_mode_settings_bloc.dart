// router imports not used in bloc
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_use_case.dart';
import 'package:bac_project/features/tests/domain/usecases/get_test_options_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_test_options_request.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../features/tests/domain/entities/test_mode.dart';
part 'test_mode_settings_event.dart';
part 'test_mode_settings_state.dart';

class TestModeSettingsBloc extends Bloc<TestModeSettingsEvent, TestModeSettingsState> {
  final GetQuestionsUsecase getQuestionsUsecase;
  final GetTestOptionsUsecase getTestOptionsUsecase;

  TestModeSettingsBloc({required this.getQuestionsUsecase, required this.getTestOptionsUsecase})
    : super(const TestModeSettingsState()) {
    on<TestModeSettingsLoadEvent>(_onLoad);
    on<TestModeSettingsUpdateModeEvent>(_onUpdateMode);
    on<TestModeSettingsSubmitEvent>(_onSubmitEvent);
    on<TestModeSettingsUpdateCategoriesEvent>(_onUpdateCategories);
    on<TestModeSettingsUpdateQuestionsCountEvent>(_onUpdateQuestionsCount);
    on<TestModeSettingsUpdateShowTrueAnswersEvent>(_onUpdateShowTrueAnswers);
    on<TestModeSettingsUpdateEnableSoundsEvent>(_onUpdateEnableSounds);
  }

  Future<void> _onLoad(TestModeSettingsLoadEvent event, Emitter<TestModeSettingsState> emit) async {
    emit(state.copyWith(status: TestModeSettingsStatus.loading));

    try {
      // Create request from event parameters
      final request = GetTestOptionsRequest(
        unitIds: event.unitIds?.map((id) => id.toString()).toList(),
        lessonIds: event.lessonIds?.map((id) => id.toString()).toList(),
      );

      // Call GetTestOptionsUsecase to fetch test options
      final result = await getTestOptionsUsecase.call(request);

      await result.fold(
        (failure) async {
          emit(state.copyWith(status: TestModeSettingsStatus.error, message: failure.message));
        },
        (response) async {
          // Create TestOptions from response and event data
          final testOptions = TestOptions(
            showTrueAnswers: false,
            enableSounds: false,
            selectedUnitsIDs: event.unitIds,
            selectedLessonsIDs: event.lessonIds,
            selectedCategories: [],
            categories: response.categories,
            selectedMode: TestMode.exploring,
          );

          emit(state.copyWith(status: TestModeSettingsStatus.loaded, testOptions: testOptions));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: TestModeSettingsStatus.error, message: e.toString()));
    }
  }

  void _onUpdateCategories(
    TestModeSettingsUpdateCategoriesEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    emit(
      state.copyWith(
        testOptions: state.testOptions.copyWith(
          selectedCategories: event.categories,
          setSelectedQuestionsCountNull: true,
        ),
      ),
    );
  }

  void _onUpdateMode(TestModeSettingsUpdateModeEvent event, Emitter<TestModeSettingsState> emit) {
    emit(
      state.copyWith(
        testOptions: state.testOptions.copyWith(
          selectedMode: event.selectedMode,
          enableSounds: false,
          showTrueAnswers: false,
        ),
      ),
    );
  }

  void _onUpdateQuestionsCount(
    TestModeSettingsUpdateQuestionsCountEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    emit(
      state.copyWith(
        testOptions: state.testOptions.copyWith(selectedQuestionsCount: event.questionsCount),
      ),
    );
  }

  void _onUpdateShowTrueAnswers(
    TestModeSettingsUpdateShowTrueAnswersEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    emit(
      state.copyWith(
        testOptions: state.testOptions.copyWith(showTrueAnswers: event.showTrueAnswers),
      ),
    );
  }

  void _onUpdateEnableSounds(
    TestModeSettingsUpdateEnableSoundsEvent event,
    Emitter<TestModeSettingsState> emit,
  ) {
    emit(state.copyWith(testOptions: state.testOptions.copyWith(enableSounds: event.enableSounds)));
  }

  Future<void> _onSubmitEvent(
    TestModeSettingsSubmitEvent event,
    Emitter<TestModeSettingsState> emit,
  ) async {
    emit(state.copyWith(status: TestModeSettingsStatus.fetchingQuestions));

    final request = GetQuestionsRequest(options: state.testOptions);

    final result = await getQuestionsUsecase.call(request);

    await result.fold(
      (failure) async {
        emit(state.copyWith(status: TestModeSettingsStatus.error, message: failure.message));
      },
      (response) async {
        emit(state.copyWith(status: TestModeSettingsStatus.saved, questions: response.questions));
      },
    );
  }
}
