import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/data/responses/get_result_response.dart';
import 'package:bac_project/features/tests/domain/requests/get_result_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_result_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_result_event.dart';
part 'explore_result_state.dart';

class ExploreResultBloc extends Bloc<ExploreResultEvent, ExploreResultState> {
  final GetResultUsecase _getResultUsecase;
  ExploreResultBloc({required GetResultUsecase getResultUsecase})
    : _getResultUsecase = getResultUsecase,
      super(const ExploreResultState()) {
    on<ExploreResultInitialize>(_onExploreResultInitialize);
    on<ExploreResultLoadResultDetails>(_onExploreResultLoadResultDetails);
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
      (GetResultResponse response) {
        emit(state.toResultDetails(response));
      },
    );
  }
}
