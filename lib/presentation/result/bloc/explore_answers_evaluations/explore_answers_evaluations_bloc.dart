import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/results/data/responses/get_result_questions_details_response.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/results/domain/requests/get_answer_evaluations_request.dart';
import 'package:bac_project/features/results/domain/usecases/get_answer_evaluations_use_case.dart';
import 'package:bac_project/features/results/domain/usecases/get_result_questions_details_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/results/domain/requests/get_result_questions_details_request.dart';

part 'explore_answers_evaluations_event.dart';
part 'explore_answers_evaluations_state.dart';

class ExploreAnswersEvaluationsBloc
    extends Bloc<ExploreAnswersEvaluationsEvent, ExploreAnswersEvaluationsState> {
  final GetResultQuestionsDetailsUsecase _getResultQuestionsDetailsUsecase;

  ExploreAnswersEvaluationsBloc()
    : _getResultQuestionsDetailsUsecase = sl<GetResultQuestionsDetailsUsecase>(),
      super(const ExploreAnswersEvaluationsState.initial()) {
    on<InitializeAnswersEvaluationsBloc>(_onInitializeAnswersEvaluationsBloc);
  }

  Future<void> _onInitializeAnswersEvaluationsBloc(
    InitializeAnswersEvaluationsBloc event,
    Emitter<ExploreAnswersEvaluationsState> emit,
  ) async {
    // Emit loading state
    emit(
      const ExploreAnswersEvaluationsState(
        status: ExploreAnswersEvaluationsStatus.loading,
        questions: [],
      ),
    );

    // Call the usecase to get evaluations
    final result = await _getResultQuestionsDetailsUsecase.call(
      GetResultQuestionsDetailsRequest(resultId: event.resultId),
    );

    result.fold(
      (failure) => emit(
        ExploreAnswersEvaluationsState(
          status: ExploreAnswersEvaluationsStatus.failure,
          questions: [],
          failure: failure,
        ),
      ),
      (GetResultQuestionsDetailsResponse evaluationsResponse) {
        emit(
          ExploreAnswersEvaluationsState(
            status: ExploreAnswersEvaluationsStatus.loaded,
            questions: evaluationsResponse.resultQuestions,
          ),
        );
      },
    );
  }
}
/*


 

المادة البيضاء مقسومة إلى قسمين متناظرين
لأنها لاحتوائها على قنوات التبويب الفولطية بكثافة عاليه
لأنها تحتوي على قنوات التبويب الفولطية
*/