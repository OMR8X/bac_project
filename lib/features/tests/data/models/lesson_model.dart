import '../../domain/entities/lesson.dart';

class LessonModel extends Lesson {
  const LessonModel({required super.id, required super.title, required super.unitId, required super.questionsCount});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      unitId: json['unit_id'] as int,
      questionsCount: json['questions_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'unit_id': unitId, 'questions_count': questionsCount};
  }

  @override
  LessonModel copyWith({int? id, String? title, int? questionsCount, int? unitId}) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      unitId: unitId ?? this.unitId,
      questionsCount: questionsCount ?? this.questionsCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonModel && other.id == id && other.title == title && other.unitId == unitId && other.questionsCount == questionsCount;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ unitId.hashCode ^ questionsCount.hashCode;

  @override
  String toString() => 'LessonModel(id: $id, title: $title, unitId: $unitId, questionsCount: $questionsCount)';
}
