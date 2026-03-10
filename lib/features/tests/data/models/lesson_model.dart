import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/lesson.dart';

part 'lesson_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.title,
    required super.unitId,
    required super.questionsCount,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  @override
  LessonModel copyWith({int? id, String? title, int? questionsCount, int? unitId}) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      unitId: unitId ?? this.unitId,
      questionsCount: questionsCount ?? this.questionsCount,
    );
  }
}
