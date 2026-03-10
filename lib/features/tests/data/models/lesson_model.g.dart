// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  unitId: (json['unit_id'] as num).toInt(),
  questionsCount: (json['questions_count'] as num).toInt(),
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'unit_id': instance.unitId,
      'questions_count': instance.questionsCount,
    };
