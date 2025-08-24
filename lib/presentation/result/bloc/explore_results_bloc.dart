import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../features/tests/domain/usecases/get_my_results_use_case.dart';
import '../../../features/tests/domain/requests/get_my_results_request.dart';
import '../../../features/tests/data/models/result_model.dart';

part 'explore_results_event.dart';
part 'explore_results_state.dart';

class ExploreResultsBloc extends Bloc<ExploreResultsEvent, ExploreResultsState> {
  final GetMyResultsUseCase getMyResultsUseCase;

  ExploreResultsBloc({required this.getMyResultsUseCase}) : super(ExploreResultsLoading()) {
    on<FetchResults>(_onFetchResults);
  }

  Future<void> _onFetchResults(FetchResults event, Emitter<ExploreResultsState> emit) async {
    emit(ExploreResultsLoading());

    final request = GetMyResultsRequest(
      lessonId: event.lessonId,
      limit: event.limit,
      offset: event.offset,
    );
    final result = await getMyResultsUseCase.call(request);

    result.fold(
      (failure) {
        // on failure emit loaded with empty list and include failure message
        emit(ExploreResultsLoaded(results: [], message: failure.message));
      },
      (response) {
        // response.results is List<ResultModel>
        emit(ExploreResultsLoaded(results: response.results));
      },
    );
  }
}
