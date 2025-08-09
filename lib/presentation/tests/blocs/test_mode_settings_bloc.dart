// router imports not used in bloc
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_use_case.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../features/tests/domain/entities/test_mode.dart';
part 'test_mode_settings_event.dart';
part 'test_mode_settings_state.dart';

class TestModeSettingsBloc extends Bloc<TestModeSettingsEvent, TestModeSettingsState> {
  final GetQuestionsUseCase getQuestionsUseCase;

  TestModeSettingsBloc({required this.getQuestionsUseCase}) : super(const TestModeSettingsState()) {
    on<TestModeSettingsLoadEvent>(_onLoad);
    on<TestModeSettingsUpdateModeEvent>(_onUpdateMode);
    on<TestModeSettingsSubmitEvent>(_fetchAndNavigate);
  }

  Future<void> _onLoad(TestModeSettingsLoadEvent event, Emitter<TestModeSettingsState> emit) async {
    emit(state.copyWith(status: TestModeSettingsStatus.loading));

    try {
      emit(state.copyWith(status: TestModeSettingsStatus.loaded, testOptions: event.testOptions));
    } catch (e) {
      emit(state.copyWith(status: TestModeSettingsStatus.error, message: e.toString()));
    }
  }

  void _onUpdateMode(TestModeSettingsUpdateModeEvent event, Emitter<TestModeSettingsState> emit) {
    emit(state.copyWith(testOptions: state.testOptions.copyWith(selectedMode: event.selectedMode)));
  }

  Future<void> _fetchAndNavigate(
    TestModeSettingsSubmitEvent event,
    Emitter<TestModeSettingsState> emit,
  ) async {
    emit(state.copyWith(status: TestModeSettingsStatus.fetchingQuestions));

    final lessonsIds = state.testOptions.selectedTestsIDs ?? <int>[];
    final request = GetQuestionsRequest(lessonsIds: lessonsIds);

    final result = await getQuestionsUseCase.call(request);

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
