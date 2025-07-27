import '../../domain/entities/lesson.dart';

class LessonModel extends Lesson {


  const LessonModel({
    required super.id,
    required super.title,
    required super.questionsLength,
    required super.unitId,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      title: json['title'] as String,
      questionsLength: json['questions_length'] as int?,
      unitId: json['unit_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions_length': questionsLength,
      'unit_id': unitId,
    };
  }


  @override
  LessonModel copyWith({
    String? id,
    String? title,
    int? questionsLength,
    String? unitId,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      questionsLength: questionsLength ?? this.questionsLength,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonModel &&
        other.id == id &&
        other.title == title &&
        other.questionsLength == questionsLength &&
        other.unitId == unitId;
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ questionsLength.hashCode ^ unitId.hashCode;

  @override
  String toString() =>
      'LessonModel(id: $id, title: $title, questionsLength: $questionsLength, unitId: $unitId)';
}
