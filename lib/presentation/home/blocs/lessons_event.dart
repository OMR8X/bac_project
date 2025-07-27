part of 'lessons_bloc.dart';

sealed class LessonsEvent {
  const LessonsEvent();
}

class LessonsEventInitialize extends LessonsEvent {
  final String? unitId;

  const LessonsEventInitialize({this.unitId});
}
