part of 'lessons_bloc.dart';

sealed class LessonsEvent {
  const LessonsEvent();
}

class LessonsEventInitialize extends LessonsEvent {
  final int? unitId;

  const LessonsEventInitialize({this.unitId});
}
