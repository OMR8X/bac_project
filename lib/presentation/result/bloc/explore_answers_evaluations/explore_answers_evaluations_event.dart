part of 'explore_answers_evaluations_bloc.dart';

sealed class ExploreAnswersEvaluationsEvent extends Equatable {
  const ExploreAnswersEvaluationsEvent();

  @override
  List<Object> get props => [];
}

final class InitializeAnswersEvaluationsBloc extends ExploreAnswersEvaluationsEvent {
  final List<Question> questions;

  const InitializeAnswersEvaluationsBloc({required this.questions});

  @override
  List<Object> get props => [questions];
}
