part of 'fetch_custom_questions_bloc.dart';

abstract class FetchCustomQuestionsState extends Equatable {
  const FetchCustomQuestionsState();

  @override
  List<Object?> get props => [];
}

class FetchCustomQuestionsInitial extends FetchCustomQuestionsState {}

class FetchCustomQuestionsLoading extends FetchCustomQuestionsState {}

class FetchCustomQuestionsSuccess extends FetchCustomQuestionsState {
  final List<int>? lessonsIds;
  final List<Question> questions;

  const FetchCustomQuestionsSuccess({required this.questions, this.lessonsIds});

  @override
  List<Object?> get props => [questions, lessonsIds];
}

class FetchCustomQuestionsFailed extends FetchCustomQuestionsState {
  final String message;

  const FetchCustomQuestionsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
