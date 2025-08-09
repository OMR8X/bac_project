part of 'quizzing_bloc.dart';

sealed class QuizzingState extends Equatable {
  const QuizzingState();

  @override
  List<Object?> get props => [];
}

final class QuizzingInitial extends QuizzingState {}

final class QuizzingLoading extends QuizzingState {
  const QuizzingLoading();
}

final class QuizzingAnswerQuestion extends QuizzingState {
  final Question currentQuestion;
  final int currentQuestionIndex;
  final int totalQuestions;
  final Duration timeLeft;
  final bool canGoNext;
  final bool canGoPrevious;
  final String? selectedAnswerId;
  final Map<int, String> selectedAnswers;

  const QuizzingAnswerQuestion({
    required this.currentQuestion,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.timeLeft,
    required this.canGoNext,
    required this.canGoPrevious,
    this.selectedAnswerId,
    this.selectedAnswers = const {},
  });

  QuizzingAnswerQuestion copyWith({
    Question? currentQuestion,
    int? currentQuestionIndex,
    int? totalQuestions,
    Duration? timeLeft,
    bool? canGoNext,
    bool? canGoPrevious,
    String? selectedAnswerId,
    Map<int, String>? selectedAnswers,
  }) {
    return QuizzingAnswerQuestion(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      timeLeft: timeLeft ?? this.timeLeft,
      canGoNext: canGoNext ?? this.canGoNext,
      canGoPrevious: canGoPrevious ?? this.canGoPrevious,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }

  @override
  List<Object?> get props => [
    currentQuestion,
    currentQuestionIndex,
    totalQuestions,
    timeLeft,
    canGoNext,
    canGoPrevious,
    selectedAnswerId,
    selectedAnswers,
  ];
}

final class QuizzingResult extends QuizzingState {
  final List<Question> questions;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int unansweredQuestions;
  final double score; // percentage
  final Duration timeTaken;

  const QuizzingResult({
    required this.questions,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unansweredQuestions,
    required this.score,
    required this.timeTaken,
  });

  @override
  List<Object> get props => [
    questions,
    totalQuestions,
    correctAnswers,
    wrongAnswers,
    unansweredQuestions,
    score,
    timeTaken,
  ];
}
