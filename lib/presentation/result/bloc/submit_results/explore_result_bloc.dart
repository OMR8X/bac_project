import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/data/responses/get_result_response.dart';
import 'package:bac_project/features/tests/domain/requests/get_result_leaderboard_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_result_request.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/usecases/get_result_leaderboard_use_case.dart';
import 'package:bac_project/features/tests/domain/usecases/get_result_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_result_event.dart';
part 'explore_result_state.dart';

class ExploreResultBloc extends Bloc<ExploreResultEvent, ExploreResultState> {
  final GetResultUsecase _getResultUsecase;
  final GetResultLeaderboardUsecase _getResultLeaderboardUsecase;
  ExploreResultBloc({
    required GetResultUsecase getResultUsecase,
    required GetResultLeaderboardUsecase getResultLeaderboardUsecase,
  }) : _getResultUsecase = getResultUsecase,
       _getResultLeaderboardUsecase = getResultLeaderboardUsecase,
       super(const ExploreResultState()) {
    on<ExploreResultInitialize>(_onExploreResultInitialize);
    on<ExploreResultLoadResultDetails>(_onExploreResultLoadResultDetails);
    on<ExploreResultLoadResultLeaderboard>(_onExploreResultLoadResultLeaderboard);
  }

  ///
  late int resultId;

  ///
  Future<void> _onExploreResultInitialize(
    ExploreResultInitialize event,
    Emitter<ExploreResultState> emit,
  ) async {
    emit(state.toLoadingDetails());
    resultId = event.resultId;
    add(const ExploreResultLoadResultDetails());
  }

  Future<void> _onExploreResultLoadResultDetails(
    ExploreResultEvent event,
    Emitter<ExploreResultState> emit,
  ) async {
    emit(state.toLoadingDetails());
    final result = await _getResultUsecase.call(GetResultRequest(resultId: resultId));
    result.fold(
      (failure) {
        emit(state.toLoadingDetailsFailure(failure));
      },
      (response) {
        emit(state.toResultDetails(response));
      },
    );
  }

  Future<void> _onExploreResultLoadResultLeaderboard(
    ExploreResultLoadResultLeaderboard event,
    Emitter<ExploreResultState> emit,
  ) async {
    emit(state.toLoadingLeaderboard());
    final result = await _getResultLeaderboardUsecase.call(
      GetResultLeaderboardRequest(resultId: resultId),
    );
    result.fold(
      (failure) {
        emit(state.toLoadingLeaderboardFailure(failure));
      },
      (response) {
        emit(state.toResultLeaderboard(response.topResults));
      },
    );
  }
}
