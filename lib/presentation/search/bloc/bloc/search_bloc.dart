import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetLessonsUsecase getLessonsUsecase;
  CancelToken? _currentToken;
  SearchBloc({required this.getLessonsUsecase}) : super(const SearchState()) {
    on<SearchLessons>(_onSearchLessons, transformer: droppable());
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchLessons(SearchLessons event, Emitter<SearchState> emit) async {
    if (state.status == SearchStatus.searching && state.status != SearchStatus.initial) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.searching));
    _currentToken?.cancel();
    _currentToken = CancelToken();
    final request = GetLessonsRequest(
      unitId: event.unitId,
      search: event.searchText,
      cancelToken: _currentToken,
    );
    final result = await getLessonsUsecase(request);
    result.fold(
      (failure) => emit(state.copyWith(status: SearchStatus.initial, message: failure.message)),
      (response) => emit(state.copyWith(status: SearchStatus.initial, lessons: response.lessons)),
    );
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}
