import 'package:bac_project/core/resources/errors/exceptions_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_by_ids_request.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_by_ids_use_case.dart';

part 'fetch_custom_questions_event.dart';
part 'fetch_custom_questions_state.dart';

class FetchCustomQuestionsBloc extends Bloc<FetchCustomQuestionsEvent, FetchCustomQuestionsState> {
  final GetQuestionsByIdsUsecase getQuestionsByIdsUsecase;

  // Store last arguments for retry functionality
  Result? _lastResult;
  List<int>? _lastQuestionIds;

  FetchCustomQuestionsBloc({required this.getQuestionsByIdsUsecase})
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
    _lastResult = event.result;
    _lastQuestionIds = null;

    emit(FetchCustomQuestionsLoading());

    try {
      final result = await getQuestionsByIdsUsecase(
        GetQuestionsByIdsRequest(questionIds: event.result?.questionsIds ?? []),
      );

      result.fold(
        (failure) => emit(FetchCustomQuestionsFailed(message: failure.message)),
        (response) => emit(
          FetchCustomQuestionsSuccess(
            questions: response.questions,
            lessonsIds: event.result != null ? [event.result!.lessonId!] : null,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(FetchCustomQuestionsFailed(message: e.toFailure.message));
    }
  }

  Future<void> _onFetchCustomQuestionsByIds(
    FetchCustomQuestionsByIds event,
    Emitter<FetchCustomQuestionsState> emit,
  ) async {
    // Store for retry
    _lastResult = null;
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
    // Retry with last used arguments
    if (_lastResult != null) {
      add(FetchCustomQuestionsByResult(result: _lastResult));
    } else if (_lastQuestionIds != null) {
      add(FetchCustomQuestionsByIds(questionIds: _lastQuestionIds!));
    }
  }
}
