part of 'explore_answers_evaluations_bloc.dart';

sealed class ExploreAnswersEvaluationsEvent extends Equatable {
  const ExploreAnswersEvaluationsEvent();

  @override
  List<Object> get props => [];
}

final class InitializeAnswersEvaluationsBloc extends ExploreAnswersEvaluationsEvent {
  final int resultId;

  const InitializeAnswersEvaluationsBloc({required this.resultId});

  @override
  List<Object> get props => [resultId];
}
