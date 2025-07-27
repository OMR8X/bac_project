import 'package:bac_project/features/tests/data/models/lesson_model.dart';

import '../../domain/entities/lesson.dart';

class GetLessonsResponse {
  final List<Lesson> lessons;
  final int totalCount;

  const GetLessonsResponse({required this.lessons, required this.totalCount});

  GetLessonsResponse copyWith({List<Lesson>? lessons, int? totalCount}) {
    return GetLessonsResponse(
      lessons: lessons ?? this.lessons,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  factory GetLessonsResponse.fromJson(Map<String, dynamic> json) {
    return GetLessonsResponse(
      lessons:
          (json['lessons'] as List).map((lesson) {
            return LessonModel.fromJson(lesson as Map<String, dynamic>);
          }).toList(),
      totalCount: json['totalCount'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetLessonsResponse &&
        other.lessons == lessons &&
        other.totalCount == totalCount;
  }

  @override
  int get hashCode => lessons.hashCode ^ totalCount.hashCode;

  @override
  String toString() => 'GetLessonsResponse(lessons: $lessons, totalCount: $totalCount)';
}
