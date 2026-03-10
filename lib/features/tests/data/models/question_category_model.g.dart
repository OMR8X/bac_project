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
  isMCQ: json['is_m_c_q'] as bool,
  isSingleAnswer: json['is_single_answer'] as bool,
);

Map<String, dynamic> _$QuestionCategoryModelToJson(
  QuestionCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'is_typeable': instance.isTypeable,
  'is_orderable': instance.isOrderable,
  'is_m_c_q': instance.isMCQ,
  'is_single_answer': instance.isSingleAnswer,
  'questions_count': instance.questionsCount,
};
