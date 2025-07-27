import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/presentation/home/models/custom_navigation_card_model.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final GetLessonsUseCase _getLessonsUseCase;

  LessonsBloc({GetLessonsUseCase? getLessonsUseCase})
    : _getLessonsUseCase = getLessonsUseCase ?? sl<GetLessonsUseCase>(),
      super(LessonsInitial()) {
    on<LessonsEventInitialize>(_onLessonsEventInitialize);
  }

  Future<void> _onLessonsEventInitialize(
    LessonsEventInitialize event,
    Emitter<LessonsState> emit,
  ) async {
    emit(LessonsLoading());
    try {
      /// Use the use case to get lessons
      final result = await _getLessonsUseCase.call(GetLessonsRequest(unitId: event.unitId));

      ///
      result.fold((failure) => emit(LessonsError(message: failure.message)), (response) {
        emit(LessonsLoaded(lessons: response.lessons));
      });
      
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }
}
