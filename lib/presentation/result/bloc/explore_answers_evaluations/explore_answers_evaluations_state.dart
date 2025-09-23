part of 'explore_answers_evaluations_bloc.dart';

enum ExploreAnswersEvaluationsStatus { loading, loaded, failure }

class ExploreAnswersEvaluationsState extends Equatable {
  final ExploreAnswersEvaluationsStatus status;

  final List<Question>? questions;
  final Failure? failure;

  const ExploreAnswersEvaluationsState({required this.status, this.questions, this.failure});

  const ExploreAnswersEvaluationsState.initial()
    : status = ExploreAnswersEvaluationsStatus.loading,

      questions = null,
      failure = null;

  @override
  List<Object?> get props => [status, questions, failure];
}
