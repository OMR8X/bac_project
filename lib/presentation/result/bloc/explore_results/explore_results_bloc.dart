import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/tests/domain/usecases/get_my_results_use_case.dart';
import '../../../../features/tests/domain/requests/get_my_results_request.dart';
import '../../../../features/tests/data/models/result_model.dart';

part 'explore_results_event.dart';
part 'explore_results_state.dart';

class ExploreResultsBloc extends Bloc<ExploreResultsEvent, ExploreResultsState> {
  final GetMyResultsUsecase getMyResultsUsecase;
  int? lessonId;
  int? limit;
  int? offset;
  ExploreResultsBloc({required this.getMyResultsUsecase}) : super(ExploreResultsLoading()) {
    on<FetchResults>(_onFetchResults);
    on<RefreshResults>(_onRefreshResults);
  }

  Future<void> _onFetchResults(FetchResults event, Emitter<ExploreResultsState> emit) async {
    emit(ExploreResultsLoading());
    lessonId = event.lessonId;
    limit = event.limit;
    offset = event.offset;
    final request = GetMyResultsRequest(lessonId: lessonId, limit: limit, offset: offset);
    final result = await getMyResultsUsecase.call(request);

    result.fold(
      (failure) {
        emit(ExploreResultsLoaded(results: [], message: failure.message));
      },
      (response) {
        emit(ExploreResultsLoaded(results: response.results));
      },
    );
  }

  Future<void> _onRefreshResults(RefreshResults event, Emitter<ExploreResultsState> emit) async {
    emit(ExploreResultsLoading());
    final request = GetMyResultsRequest(lessonId: lessonId, limit: limit, offset: offset);
    final result = await getMyResultsUsecase.call(request);
    result.fold(
      (failure) {
        emit(ExploreResultsLoaded(results: [], message: failure.message));
      },
      (response) {
        emit(ExploreResultsLoaded(results: response.results));
      },
    );
  }
}
