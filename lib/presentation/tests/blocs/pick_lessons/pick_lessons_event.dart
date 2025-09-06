part of 'pick_lessons_bloc.dart';

sealed class PickLessonsEvent extends Equatable {
  const PickLessonsEvent();

  @override
  List<Object> get props => [];
}

class PickLessonsInitializeEvent extends PickLessonsEvent {
  final int unitId;

  const PickLessonsInitializeEvent({required this.unitId});

  @override
  List<Object> get props => [unitId];
}

class SelectLessonEvent extends PickLessonsEvent {
  final Lesson lesson;

  const SelectLessonEvent({required this.lesson});

  @override
  List<Object> get props => [lesson];
}

class UnselectLessonEvent extends PickLessonsEvent {
  final Lesson lesson;

  const UnselectLessonEvent({required this.lesson});

  @override
  List<Object> get props => [lesson];
}

class SelectAllLessonsEvent extends PickLessonsEvent {
  const SelectAllLessonsEvent();

  @override
  List<Object> get props => [];
}

class UnselectAllLessonsEvent extends PickLessonsEvent {
  const UnselectAllLessonsEvent();

  @override
  List<Object> get props => [];
}
