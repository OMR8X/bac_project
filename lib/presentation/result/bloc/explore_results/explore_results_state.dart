part of 'explore_results_bloc.dart';

enum ExploreResultsStatus {
  loading,
  loaded,
  failure,
}

class ExploreResultsState extends Equatable {
  const ExploreResultsState({
    this.status = ExploreResultsStatus.loading,
    this.results = const [],
    this.failure,
  });

  final ExploreResultsStatus status;
  final List<Result> results;
  final Failure? failure;

  const ExploreResultsState.loading() : this(status: ExploreResultsStatus.loading);

  const ExploreResultsState.loaded(List<Result> results)
    : this(status: ExploreResultsStatus.loaded, results: results);

  const ExploreResultsState.failure(Failure failure)
    : this(status: ExploreResultsStatus.failure, failure: failure);

  bool get isLoading => status == ExploreResultsStatus.loading;
  bool get isLoaded => status == ExploreResultsStatus.loaded;
  bool get isFailure => status == ExploreResultsStatus.failure;

  @override
  List<Object?> get props => [status, results, failure];
}
