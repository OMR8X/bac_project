import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/results/domain/usecases/get_my_results_use_case.dart';
import '../../../../features/results/domain/requests/get_my_results_request.dart';

part 'explore_results_event.dart';
part 'explore_results_state.dart';

class ExploreResultsBloc extends Bloc<ExploreResultsEvent, ExploreResultsState> {
  final GetMyResultsUsecase getMyResultsUsecase;
  int? lessonId;
  int? limit;
  int? offset;
  ExploreResultsBloc({required this.getMyResultsUsecase})
    : super(const ExploreResultsState.loading()) {
    on<FetchResults>(_onFetchResults);
    on<RefreshResults>(_onRefreshResults);
  }

  Future<void> _onFetchResults(FetchResults event, Emitter<ExploreResultsState> emit) async {
    emit(const ExploreResultsState.loading());

    lessonId = event.lessonId;
    limit = event.limit;
    offset = event.offset;
    final request = GetMyResultsRequest(lessonId: lessonId, limit: limit, offset: offset);
    final result = await getMyResultsUsecase.call(request);

    result.fold(
      (failure) {
        emit(ExploreResultsState.failure(failure));
      },
      (response) {
        emit(ExploreResultsState.loaded(response.results));
      },
    );
  }

  Future<void> _onRefreshResults(RefreshResults event, Emitter<ExploreResultsState> emit) async {
    emit(const ExploreResultsState.loading());
    final request = GetMyResultsRequest(lessonId: lessonId, limit: limit, offset: offset);
    final result = await getMyResultsUsecase.call(request);
    result.fold(
      (failure) {
        emit(ExploreResultsState.failure(failure));
      },
      (response) {
        emit(ExploreResultsState.loaded(response.results));
      },
    );
  }
}
