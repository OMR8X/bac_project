import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';
import 'package:bac_project/core/resources/errors/failures.dart';

part 'pick_lessons_event.dart';
part 'pick_lessons_state.dart';

class PickLessonsBloc extends Bloc<PickLessonsEvent, PickLessonsState> {
  final GetLessonsUseCase getLessonsUseCase;

  PickLessonsBloc({required this.getLessonsUseCase}) : super(const PickLessonsState()) {
    on<PickLessonsInitializeEvent>(_onInitializePickedLessons);
    on<SelectLessonEvent>(_onSelectLesson);
    on<UnselectLessonEvent>(_onUnselectLesson);
    on<SelectAllLessonsEvent>(_onSelectAllLessons);
    on<UnselectAllLessonsEvent>(_onUnselectAllLessons);
  }

  Future<void> _onInitializePickedLessons(
    PickLessonsInitializeEvent event,
    Emitter<PickLessonsState> emit,
  ) async {
    emit(state.copyWith(status: PickLessonsStatus.loading));
    final result = await getLessonsUseCase(GetLessonsRequest(unitId: event.unitId));
    result.fold(
      (failure) => emit(state.copyWith(status: PickLessonsStatus.error, failure: failure)),
      (response) =>
          emit(state.copyWith(status: PickLessonsStatus.loaded, allLessons: response.lessons)),
    );
  }

  void _onSelectLesson(SelectLessonEvent event, Emitter<PickLessonsState> emit) {
    final updatedPickedLessonsId = List<int>.from(state.pickedLessonsId)..add(event.lesson.id);
    emit(state.copyWith(pickedLessonsId: updatedPickedLessonsId));
  }

  void _onUnselectLesson(UnselectLessonEvent event, Emitter<PickLessonsState> emit) {
    final updatedPickedLessonsId = List<int>.from(state.pickedLessonsId)
      ..removeWhere((lessonId) => lessonId == event.lesson.id);
    emit(state.copyWith(pickedLessonsId: updatedPickedLessonsId));
  }

  void _onSelectAllLessons(SelectAllLessonsEvent event, Emitter<PickLessonsState> emit) {
    final allIds = state.allLessons.map((lesson) => lesson.id).toList();
    emit(state.copyWith(pickedLessonsId: allIds));
  }

  void _onUnselectAllLessons(UnselectAllLessonsEvent event, Emitter<PickLessonsState> emit) {
    emit(state.copyWith(pickedLessonsId: []));
  }
}
