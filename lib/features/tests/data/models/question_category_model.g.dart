// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCategoryModel _$QuestionCategoryModelFromJson(
  Map<String, dynamic> json,
) => QuestionCategoryModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  questionsCount: (json['questions_count'] as num?)?.toInt(),
  isTypeable: json['is_typeable'] as bool,
  isOrderable: json['is_orderable'] as bool,
  isMCQ: json['is_mcq'] as bool,
  isSingleAnswer: json['is_single_answer'] as bool,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$QuestionCategoryModelToJson(
  QuestionCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'is_typeable': instance.isTypeable,
  'is_orderable': instance.isOrderable,
  'is_mcq': instance.isMCQ,
  'is_single_answer': instance.isSingleAnswer,
  'questions_count': instance.questionsCount,
  'sort_order': instance.sortOrder,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
