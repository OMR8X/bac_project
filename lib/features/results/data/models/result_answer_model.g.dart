// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultAnswerModel _$ResultAnswerModelFromJson(Map<String, dynamic> json) =>
    ResultAnswerModel(
      id: (json['id'] as num).toInt(),
      resultId: (json['result_id'] as num).toInt(),
      questionId: (json['question_id'] as num).toInt(),
      optionId: (json['option_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResultAnswerModelToJson(ResultAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result_id': instance.resultId,
      'question_id': instance.questionId,
      'option_id': instance.optionId,
    };
