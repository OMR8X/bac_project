part of 'lessons_bloc.dart';

@immutable
abstract class LessonsState {}

class LessonsInitial extends LessonsState {}

class LessonsLoading extends LessonsState {}

class LessonsLoaded extends LessonsState {
  final List<Lesson> lessons;

  LessonsLoaded({required this.lessons});
}

class LessonsError extends LessonsState {
  final String message;

  LessonsError({required this.message});
}
