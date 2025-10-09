import 'package:bac_project/features/tests/data/models/lesson_model.dart';

import '../../domain/entities/lesson.dart';

class GetLessonsResponse {
  final List<Lesson> lessons;

  const GetLessonsResponse({required this.lessons});

  GetLessonsResponse copyWith({List<Lesson>? lessons}) {
    return GetLessonsResponse(lessons: lessons ?? this.lessons);
  }

  factory GetLessonsResponse.fromJson(Map<String, dynamic> json) {
    return GetLessonsResponse(
      lessons:
          (json['lessons'] as List?)?.map((lesson) {
            return LessonModel.fromJson(lesson as Map<String, dynamic>);
          }).toList() ??
          [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLessonsResponse && other.lessons == lessons;
  }

  @override
  int get hashCode => lessons.hashCode;

  @override
  String toString() => 'GetLessonsResponse(lessons: $lessons)';
}
