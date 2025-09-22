part of 'quizzing_bloc.dart';

sealed class QuizzingEvent extends Equatable {
  const QuizzingEvent();

  @override
  List<Object> get props => [];
}

class InitializeQuiz extends QuizzingEvent {
  final TestMode testMode;
  final int? lessonId;
  final List<Question> questions;
  final int timeLimit; // in minutes

  const InitializeQuiz({
    required this.questions,
    required this.timeLimit,
    required this.lessonId,
    required this.testMode,
  });

  @override
  List<Object> get props => [questions, timeLimit, testMode];
}

class UpdateQuestionAnswersEvent extends QuizzingEvent {
  final List<QuestionAnswer> answers;

  const UpdateQuestionAnswersEvent({required this.answers});

  @override
  List<Object> get props => [answers];
}

class NextQuestion extends QuizzingEvent {
  const NextQuestion();
}

class PreviousQuestion extends QuizzingEvent {
  const PreviousQuestion();
}

class SubmitQuiz extends QuizzingEvent {
  const SubmitQuiz();
}

class CloseQuiz extends QuizzingEvent {
  const CloseQuiz();
}

class UpdateState extends QuizzingEvent {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class RetryUploadResult extends QuizzingEvent {
  const RetryUploadResult();

  @override
  List<Object> get props => [];
}
