part of 'explore_result_bloc.dart';

enum ExploreResultStatus { loading, loaded, failure }

final class ExploreResultState extends Equatable {
  const ExploreResultState({
    this.status = ExploreResultStatus.loading,
    this.response,
    this.failure,
  });
  final ExploreResultStatus status;
  final GetResultResponse? response;
  final Failure? failure;

  ExploreResultState copyWith({
    ExploreResultStatus? status,
    GetResultResponse? response,
    Failure? failure,
  }) {
    return ExploreResultState(
      status: status ?? this.status,
      response: response ?? this.response,
      failure: failure ?? this.failure,
    );
  }

  ExploreResultState toLoadingDetailsFailure(Failure failure) {
    return copyWith(status: ExploreResultStatus.failure, failure: failure);
  }

  ExploreResultState toLoadingDetails() {
    return copyWith(status: ExploreResultStatus.loading);
  }

  ExploreResultState toResultDetails(GetResultResponse response) {
    return copyWith(status: ExploreResultStatus.loaded, response: response);
  }

  @override
  List<Object?> get props => [status, response, failure];
}
