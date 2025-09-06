part of 'explore_results_bloc.dart';

sealed class ExploreResultsEvent extends Equatable {
  const ExploreResultsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchResults extends ExploreResultsEvent {
  final int? lessonId;
  final int? limit;
  final int? offset;

  const FetchResults({this.lessonId, this.limit, this.offset});

  @override
  List<Object?> get props => [lessonId, limit, offset];
}

final class RefreshResults extends ExploreResultsEvent {
  const RefreshResults();

  @override
  List<Object?> get props => [];
}
