import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/requests/get_answer_evaluations_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_answer_evaluations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_answers_evaluations_event.dart';
part 'explore_answers_evaluations_state.dart';

class ExploreAnswersEvaluationsBloc
    extends Bloc<ExploreAnswersEvaluationsEvent, ExploreAnswersEvaluationsState> {
  final GetAnswerEvaluationsUsecase _getAnswerEvaluationsUsecase;

  ExploreAnswersEvaluationsBloc()
    : _getAnswerEvaluationsUsecase = sl<GetAnswerEvaluationsUsecase>(),
      super(const ExploreAnswersEvaluationsState.initial()) {
    on<InitializeAnswersEvaluationsBloc>(_onInitializeAnswersEvaluationsBloc);
  }

  Future<void> _onInitializeAnswersEvaluationsBloc(
    InitializeAnswersEvaluationsBloc event,
    Emitter<ExploreAnswersEvaluationsState> emit,
  ) async {
    // Extract all answer IDs from all questions' questionAnswers
    final answerIds =
        event.questions.expand((question) => question.questionAnswers).map((answer) {
          print(answer.answerText);
          return answer.id;
        }).toList();

    // Emit loading state
    emit(
      const ExploreAnswersEvaluationsState(
        status: ExploreAnswersEvaluationsStatus.loading,
        questions: [],
      ),
    );

    // Call the usecase to get evaluations
    final result = await _getAnswerEvaluationsUsecase.call(
      GetAnswerEvaluationsRequest(answerIds: answerIds),
    );

    result.fold(
      (failure) => emit(
        ExploreAnswersEvaluationsState(
          status: ExploreAnswersEvaluationsStatus.failure,
          questions: event.questions,
          failure: failure,
        ),
      ),
      (evaluationsResponse) {
        final updatedQuestions =
            event.questions.map((question) {
              final questionEvaluations =
                  evaluationsResponse.answerEvaluations
                      .where(
                        (evaluation) =>
                            evaluation.questionAnswerId == question.questionAnswers.first.id,
                      )
                      .toList();
              return question.copyWith(answerEvaluations: questionEvaluations);
            }).toList();

        emit(
          ExploreAnswersEvaluationsState(
            status: ExploreAnswersEvaluationsStatus.loaded,
            questions: updatedQuestions,
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