import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/usecases/add_result_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/add_result_request.dart';
import 'package:bac_project/features/tests/data/models/user_answer_model.dart';
import 'package:bac_project/core/injector/app_injection.dart';

part 'quizzing_event.dart';
part 'quizzing_state.dart';

class QuizzingBloc extends Bloc<QuizzingEvent, QuizzingState> {
  /// Use case to submit results
  final AddResultUsecase _addResultUsecase;

  ///
  QuizzingBloc({AddResultUsecase? addResultUsecase})
    : _addResultUsecase = addResultUsecase ?? sl<AddResultUsecase>(),
      super(QuizzingLoading()) {
    on<InitializeQuiz>(_onInitializeQuiz);
    on<OptionQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CloseQuiz>(_onCloseQuiz);
    on<SubmitQuiz>(_onSubmitQuiz);
    on<UpdateState>(_onUpdateState);
    on<RetryUploadResult>(_onRetryUploadResult);
  }

  ///
  late Timer _timer;
  late DateTime _startTime;
  late int? _lessonId;
  late List<Question> _questions;
  late Duration _timeLeft;
  late Duration _initialTimeLimit;
  late Map<int, int?> _selectedAnswers;

  void _onInitializeQuiz(InitializeQuiz event, Emitter<QuizzingState> emit) {
    ///
    emit(const QuizzingLoading());

    ///
    // Limit questions to a maximum of 15
    _questions = event.questions;
    _lessonId = event.lessonId;
    _selectedAnswers = {};
    _startTime = DateTime.now();
    _initialTimeLimit = Duration(minutes: event.timeLimit);
    _timeLeft = _initialTimeLimit;
    //
    for (var q in _questions) {
      _selectedAnswers[q.id] = null;
    }

    /// Start timer
    _startTimer();

    ///
    emit(
      QuizzingAnswerQuestion(
        currentQuestion: _questions[0],
        currentQuestionIndex: 0,
        totalQuestions: _questions.length,
        timeLeft: _timeLeft,
        canGoNext: _questions.length > 1,
        canGoPrevious: false,
        selectedAnswerId: null,
        selectedAnswers: Map<int, int?>.from(_selectedAnswers),
      ),
    );
  }

  void _onAnswerQuestion(OptionQuestion event, Emitter<QuizzingState> emit) {
    if (state is QuizzingAnswerQuestion) {
      /// Get the current state
      final currentState = state as QuizzingAnswerQuestion;

      ///
      if (currentState.timeLeft.inSeconds <= 0) return;

      /// Store the selected answer
      _selectedAnswers[currentState.currentQuestion.id] = event.answerId;

      /// Update the state: include full selectedAnswers map so UI can read per-question answers
      emit(
        currentState.copyWith(
          selectedAnswerId: event.answerId,
          selectedAnswers: Map<int, int?>.from(_selectedAnswers),
        ),
      );
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizzingState> emit) {
    if (state is QuizzingAnswerQuestion) {
      /// Get the current state
      final currentState = state as QuizzingAnswerQuestion;
      final nextIndex = currentState.currentQuestionIndex + 1;

      ///
      if (nextIndex < _questions.length) {
        final nextQuestion = _questions[nextIndex];
        final selectedAnswerId = _selectedAnswers[nextQuestion.id];

        /// Update the state
        emit(
          currentState.copyWith(
            currentQuestionIndex: nextIndex,
            currentQuestion: nextQuestion,
            canGoNext: nextIndex < _questions.length - 1,
            canGoPrevious: true,
            selectedAnswerId: selectedAnswerId,
            selectedAnswers: Map<int, int?>.from(_selectedAnswers),
          ),
        );
      }
    }
  }

  void _onPreviousQuestion(PreviousQuestion event, Emitter<QuizzingState> emit) {
    if (state is QuizzingAnswerQuestion) {
      /// Get the current state
      final currentState = state as QuizzingAnswerQuestion;

      ///
      if (currentState.timeLeft.inSeconds <= 0) {
        add(const SubmitQuiz());
        return;
      }

      final previousIndex = currentState.currentQuestionIndex - 1;

      if (previousIndex >= 0) {
        final previousQuestion = _questions[previousIndex];
        final selectedAnswerId = _selectedAnswers[previousQuestion.id];

        emit(
          currentState.copyWith(
            currentQuestionIndex: previousIndex,
            currentQuestion: previousQuestion,
            canGoNext: true,
            canGoPrevious: previousIndex > 0,
            selectedAnswerId: selectedAnswerId,
            selectedAnswers: Map<int, int?>.from(_selectedAnswers),
          ),
        );
      }
    }
  }

  void _onCloseQuiz(CloseQuiz event, Emitter<QuizzingState> emit) {
    add(const SubmitQuiz());
  }

  Future<void> _onSubmitQuiz(SubmitQuiz event, Emitter<QuizzingState> emit) async {
    emit(const QuizzingUploadingResult());

    /// Stop the timer
    _stopTimer();

    /// Calculate values
    final durationSeconds = DateTime.now().difference(_startTime).inSeconds;
    final answers =
        _questions
            .map((q) => UserAnswerModel(questionId: q.id, selectedOptionId: _selectedAnswers[q.id]))
            .toList();

    /// Upload the result
    final response = await _addResultUsecase.call(
      AddResultRequest(
        lessonId: _lessonId,
        durationSeconds: durationSeconds,
        questionsIds: _questions.map((q) => q.id).toList(),
        answers: answers,
      ),
    );

    response.fold(
      (failure) {
        emit(QuizzingFailedUploadingResult(failure: failure));
      },
      (response) {
        emit(QuizzingResultUploaded(result: response.result));
      },
    );
  }

  void _onUpdateState(UpdateState event, Emitter<QuizzingState> emit) {
    if (state is QuizzingAnswerQuestion) {
      final currentState = state as QuizzingAnswerQuestion;
      emit(currentState.copyWith(timeLeft: _timeLeft));
    }
  }

  void _onRetryUploadResult(RetryUploadResult event, Emitter<QuizzingState> emit) {
    add(const SubmitQuiz());
  }

  void _startTimer() {
    final Duration interval = const Duration(milliseconds: 100);
    _timer = Timer.periodic(interval, (timer) {
      if (state is QuizzingAnswerQuestion) {
        _timeLeft = _timeLeft - interval;
        if (_timeLeft.inSeconds <= 0) {
          _stopTimer();
          add(const SubmitQuiz());
        } else {
          add(UpdateState());
        }
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
