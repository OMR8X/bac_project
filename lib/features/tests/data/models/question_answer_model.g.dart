// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAnswerModel _$QuestionAnswerModelFromJson(Map<String, dynamic> json) =>
    QuestionAnswerModel(
      id: (json['id'] as num).toInt(),
      resultId: (json['result_id'] as num).toInt(),
      questionId: (json['question_id'] as num).toInt(),
      optionId: (json['option_id'] as num?)?.toInt(),
      answerText: json['answer_text'] as String?,
      answerPosition: (json['answer_position'] as num?)?.toInt(),
      isCorrect: json['is_correct'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionAnswerModelToJson(
  QuestionAnswerModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'result_id': instance.resultId,
  'question_id': instance.questionId,
  'option_id': instance.optionId,
  'answer_text': instance.answerText,
  'answer_position': instance.answerPosition,
  'is_correct': instance.isCorrect,
};
