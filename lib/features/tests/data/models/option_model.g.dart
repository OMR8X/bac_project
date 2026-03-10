// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) => OptionModel(
  id: (json['id'] as num).toInt(),
  questionId: (json['question_id'] as num).toInt(),
  content: json['content'] as String,
  isCorrect: json['is_correct'] as bool?,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
);

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'content': instance.content,
      'is_correct': instance.isCorrect,
      'sort_order': instance.sortOrder,
    };
