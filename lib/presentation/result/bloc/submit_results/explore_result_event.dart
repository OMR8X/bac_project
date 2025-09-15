part of 'explore_result_bloc.dart';

sealed class ExploreResultEvent extends Equatable {
  const ExploreResultEvent();
  @override
  List<Object?> get props => [];
}

final class ExploreResultInitialize extends ExploreResultEvent {
  final int resultId;
  const ExploreResultInitialize({required this.resultId});
  @override
  List<Object?> get props => [resultId];
}

final class ExploreResultLoadResultDetails extends ExploreResultEvent {
  const ExploreResultLoadResultDetails();
  @override
  List<Object?> get props => [];
}
