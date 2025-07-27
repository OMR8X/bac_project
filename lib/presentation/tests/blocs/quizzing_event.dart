part of 'quizzing_bloc.dart';

sealed class QuizzingEvent extends Equatable {
  const QuizzingEvent();

  @override
  List<Object> get props => [];
}

class InitializeQuiz extends QuizzingEvent {
  final List<Question> questions;
  final int timeLimit; // in minutes

  const InitializeQuiz({required this.questions, required this.timeLimit});

  @override
  List<Object> get props => [questions, timeLimit];
}

class OptionQuestion extends QuizzingEvent {
  final String answerId;
  final int questionIndex;

  const OptionQuestion({required this.answerId, required this.questionIndex});

  @override
  List<Object> get props => [answerId, questionIndex];
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
