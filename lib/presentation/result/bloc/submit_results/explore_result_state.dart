part of 'explore_result_bloc.dart';

enum ExploreResultStatus {
  loadingResultDetails,
  loadingResultLeaderboard,
  resultDetails,
  resultLeaderboard,
  loadingDetailsFailure,
  loadingLeaderboardFailure,
}

final class ExploreResultState extends Equatable {
  const ExploreResultState({
    this.status = ExploreResultStatus.loadingResultDetails,
    this.response,
    this.leaderboardList,
    this.failure,
  });
  final ExploreResultStatus status;
  final GetResultResponse? response;
  final List<Result>? leaderboardList;
  final Failure? failure;

  ExploreResultState copyWith({
    ExploreResultStatus? status,
    GetResultResponse? response,
    List<Result>? leaderboardList,
    Failure? failure,
  }) {
    return ExploreResultState(
      status: status ?? this.status,
      response: response ?? this.response,
      leaderboardList: leaderboardList ?? this.leaderboardList,
      failure: failure ?? this.failure,
    );
  }

  ExploreResultState toLoadingDetailsFailure(Failure failure) {
    return copyWith(status: ExploreResultStatus.loadingDetailsFailure, failure: failure);
  }

  ExploreResultState toLoadingLeaderboardFailure(Failure failure) {
    return copyWith(status: ExploreResultStatus.loadingLeaderboardFailure, failure: failure);
  }

  ExploreResultState toLoadingDetails() {
    return copyWith(status: ExploreResultStatus.loadingResultDetails);
  }

  ExploreResultState toLoadingLeaderboard() {
    return copyWith(status: ExploreResultStatus.loadingResultLeaderboard);
  }

  ExploreResultState toResultDetails(GetResultResponse response) {
    return copyWith(status: ExploreResultStatus.resultDetails, response: response);
  }

  ExploreResultState toResultLeaderboard(List<Result> leaderboardList) {
    return copyWith(
      status: ExploreResultStatus.resultLeaderboard,
      leaderboardList: leaderboardList,
    );
  }

  @override
  List<Object?> get props => [status, response, leaderboardList, failure];
}
