// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_evaluation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerEvaluationModel _$AnswerEvaluationModelFromJson(
  Map<String, dynamic> json,
) => AnswerEvaluationModel(
  id: (json['id'] as num).toInt(),
  questionAnswerId: (json['question_answer_id'] as num).toInt(),
  isCorrect: json['is_correct'] as bool,
  confidence: (json['confidence'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  modelName: json['model_name'] as String?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AnswerEvaluationModelToJson(
  AnswerEvaluationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'question_answer_id': instance.questionAnswerId,
  'is_correct': instance.isCorrect,
  'confidence': instance.confidence,
  'notes': instance.notes,
  'model_name': instance.modelName,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
