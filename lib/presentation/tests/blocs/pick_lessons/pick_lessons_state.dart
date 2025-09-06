part of 'pick_lessons_bloc.dart';

enum PickLessonsStatus { initial, loading, loaded, error }

class PickLessonsState extends Equatable {
  final PickLessonsStatus status;
  final List<Lesson> allLessons;
  final List<int> pickedLessonsId;
  final Failure? failure;

  const PickLessonsState({
    this.status = PickLessonsStatus.initial,
    this.allLessons = const [],
    this.pickedLessonsId = const [],
    this.failure,
  });

  PickLessonsState copyWith({
    PickLessonsStatus? status,
    List<Lesson>? allLessons,
    List<int>? pickedLessonsId,
    Failure? failure,
  }) {
    return PickLessonsState(
      status: status ?? this.status,
      allLessons: allLessons ?? this.allLessons,
      pickedLessonsId: pickedLessonsId ?? this.pickedLessonsId,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, allLessons, pickedLessonsId, failure];
}
