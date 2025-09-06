part of 'quizzing_bloc.dart';

sealed class QuizzingState extends Equatable {
  const QuizzingState();

  @override
  List<Object?> get props => [];
}

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
  final int? selectedAnswerId;
  final Map<int, int?> selectedAnswers;

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
    int? selectedAnswerId,
    Map<int, int?>? selectedAnswers,
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

final class QuizzingUploadingResult extends QuizzingState {
  const QuizzingUploadingResult();

  @override
  List<Object> get props => [];
}

final class QuizzingFailedUploadingResult extends QuizzingState {
  final Failure failure;
  const QuizzingFailedUploadingResult({required this.failure});

  @override
  List<Object> get props => [];
}

final class QuizzingResultUploaded extends QuizzingState {
  final Result result;
  const QuizzingResultUploaded({required this.result});

  @override
  List<Object> get props => [result];
}
