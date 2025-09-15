import 'package:bac_project/core/resources/errors/exceptions_mapper.dart';
import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_by_ids_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_result_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_result_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_by_ids_use_case.dart';

part 'fetch_custom_questions_event.dart';
part 'fetch_custom_questions_state.dart';

class FetchCustomQuestionsBloc extends Bloc<FetchCustomQuestionsEvent, FetchCustomQuestionsState> {
  final GetQuestionsByIdsUsecase getQuestionsByIdsUsecase;
  final GetResultUsecase getResultUsecase;

  // Store last arguments for retry functionality
  int? _lastResultId;
  List<int>? _lastQuestionIds;

  FetchCustomQuestionsBloc({required this.getQuestionsByIdsUsecase, required this.getResultUsecase})
    : super(FetchCustomQuestionsInitial()) {
    on<FetchCustomQuestionsByResult>(_onFetchCustomQuestionsByResult);
    on<FetchCustomQuestionsByIds>(_onFetchCustomQuestionsByIds);
    on<FetchCustomQuestionsRetry>(_onFetchCustomQuestionsRetry);
  }

  Future<void> _onFetchCustomQuestionsByResult(
    FetchCustomQuestionsByResult event,
    Emitter<FetchCustomQuestionsState> emit,
  ) async {
    // Store for retry
    _lastResultId = event.resultId;
    _lastQuestionIds = null;

    emit(FetchCustomQuestionsLoading());

    try {
      final result = await getResultUsecase(GetResultRequest(resultId: event.resultId));
      await result.fold(
        (failure) async => emit(FetchCustomQuestionsFailed(message: failure.message)),
        (response) async {
          ///

          ///
          final result = await getQuestionsByIdsUsecase(
            GetQuestionsByIdsRequest(questionIds: response.result.answers.map((e) => e.questionId).toList()),
          );

          ///
          result.fold(
            (failure) => emit(FetchCustomQuestionsFailed(message: failure.message)),
            (GetQuestionsResponse response) => emit(
              FetchCustomQuestionsSuccess(
                questions: response.questions,
                lessonsIds: response.questions.map((e) => e.lessonId).toSet().toList(),
              ),
            ),
          );
        },
      );
    } on Exception catch (e) {
      emit(FetchCustomQuestionsFailed(message: e.toFailure.message));
    }
  }

  Future<void> _onFetchCustomQuestionsByIds(
    FetchCustomQuestionsByIds event,
    Emitter<FetchCustomQuestionsState> emit,
  ) async {
    _lastQuestionIds = event.questionIds;

    emit(FetchCustomQuestionsLoading());

    try {
      final result = await getQuestionsByIdsUsecase(
        GetQuestionsByIdsRequest(questionIds: event.questionIds),
      );

      result.fold(
        (failure) => emit(FetchCustomQuestionsFailed(message: failure.message)),
        (response) => emit(FetchCustomQuestionsSuccess(questions: response.questions)),
      );
    } on Exception catch (e) {
      emit(FetchCustomQuestionsFailed(message: e.toFailure.message));
    }
  }

  Future<void> _onFetchCustomQuestionsRetry(
    FetchCustomQuestionsRetry event,
    Emitter<FetchCustomQuestionsState> emit,
  ) async {
    if (_lastResultId != null) {
      add(FetchCustomQuestionsByResult(resultId: _lastResultId!));
    } else if (_lastQuestionIds != null) {
      add(FetchCustomQuestionsByIds(questionIds: _lastQuestionIds!));
    }
  }
}
