part of 'explore_results_bloc.dart';

sealed class ExploreResultsState extends Equatable {
  const ExploreResultsState();
  @override
  List<Object?> get props => [];
}

final class ExploreResultsLoading extends ExploreResultsState {}

final class ExploreResultsLoaded extends ExploreResultsState {
  final List<Result> results; // List<ResultModel> but keep dynamic to avoid import here

  final String? message;

  const ExploreResultsLoaded({required this.results, this.message});

  @override
  List<Object?> get props => [results, message];
}
