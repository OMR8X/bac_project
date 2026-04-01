// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      options:
          json['options'] == null
              ? []
              : QuestionModel._optionsFromJson(json['options'] as List?),
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
      unitId: (json['unit_id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num).toInt(),
      questionImageUrl: json['question_image_url'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      hintContent: json['hint_content'] as String?,
      hintImageUrl: json['hint_image_url'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      questionAnswers:
          json['question_answers'] == null
              ? const []
              : QuestionModel._questionAnswersFromJson(
                json['question_answers'] as List?,
              ),
      answerEvaluations:
          json['answer_evaluations'] == null
              ? const []
              : QuestionModel._answerEvaluationsFromJson(
                json['answer_evaluations'] as List?,
              ),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'unit_id': instance.unitId,
      'lesson_id': instance.lessonId,
      'question_image_url': instance.questionImageUrl,
      'type': _$QuestionTypeEnumMap[instance.type],
      'category_id': instance.categoryId,
      'hint_content': instance.hintContent,
      'hint_image_url': instance.hintImageUrl,
      'sort_order': instance.sortOrder,
      'options': QuestionModel._optionsToJson(instance.options),
      'question_answers': QuestionModel._questionAnswersToJson(
        instance.questionAnswers,
      ),
      'answer_evaluations': QuestionModel._answerEvaluationsToJson(
        instance.answerEvaluations,
      ),
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.trueFalse: 'trueFalse',
  QuestionType.textEntry: 'textEntry',
};
