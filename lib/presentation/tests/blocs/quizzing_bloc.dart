import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:bac_project/features/tests/domain/entities/question.dart';

part 'quizzing_event.dart';
part 'quizzing_state.dart';

class QuizzingBloc extends Bloc<QuizzingEvent, QuizzingState> {
  ///
  QuizzingBloc() : super(QuizzingInitial()) {
    on<InitializeQuiz>(_onInitializeQuiz);
    on<OptionQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<CloseQuiz>(_onCloseQuiz);
    on<SubmitQuiz>(_onSubmitQuiz);
    on<UpdateState>(_onUpdateState);
  }

  ///
  late Timer _timer;
  late DateTime _startTime;
  late List<Question> _questions;
  late Duration _timeLeft;
  late Map<String, String> _selectedAnswers;

  void _onInitializeQuiz(InitializeQuiz event, Emitter<QuizzingState> emit) {
    ///
    emit(const QuizzingLoading());

    ///
    _questions = event.questions;
    _selectedAnswers = {};
    _startTime = DateTime.now();
    _timeLeft = Duration(minutes: event.timeLimit);

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

      /// Update the state
      emit(currentState.copyWith(selectedAnswerId: event.answerId));
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
          ),
        );
      }
    }
  }

  void _onCloseQuiz(CloseQuiz event, Emitter<QuizzingState> emit) {
    add(const SubmitQuiz());
  }

  void _onSubmitQuiz(SubmitQuiz event, Emitter<QuizzingState> emit) {
    /// Stop the timer
    _stopTimer();

    ///
    int correctAnswers = 0;
    int wrongAnswers = 0;
    int unansweredQuestions = 0;

    /// Calculate the results
    for (final question in _questions) {
      /// Get the selected answer
      final selectedAnswerId = _selectedAnswers[question.id];

      /// If the answer is not selected, it is unanswered
      if (selectedAnswerId == null) {
        unansweredQuestions++;
      } else {
        /// check if the answer is correct
        if (question.trueAnswers(selectedAnswerId)) {
          correctAnswers++;
        } else {
          wrongAnswers++;
        }
      }
    }

    /// Calculate the score
    final score = (_questions.isNotEmpty) ? (correctAnswers / _questions.length) * 100 : 0.0;

    /// Calculate the time taken
    final timeTaken = DateTime.now().difference(_startTime);

    /// Emit the result
    emit(
      QuizzingResult(
        questions: _questions,
        totalQuestions: _questions.length,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        unansweredQuestions: unansweredQuestions,
        score: score,
        timeTaken: timeTaken,
      ),
    );
  }

  void _onUpdateState(UpdateState event, Emitter<QuizzingState> emit) {
    if (state is QuizzingAnswerQuestion) {
      final currentState = state as QuizzingAnswerQuestion;
      emit(currentState.copyWith(timeLeft: _timeLeft));
    }
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
