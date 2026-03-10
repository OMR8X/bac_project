// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
  id: (json['id'] as num).toInt(),
  userId: json['user_id'] as String,
  lessonId: (json['lesson_id'] as num?)?.toInt(),
  lessonTitle: json['lesson_title'] as String?,
  resultOrder: (json['user_rank'] as num?)?.toInt(),
  totalQuestions: (json['total_questions'] as num).toInt(),
  correctAnswers: (json['correct_answers'] as num).toInt(),
  wrongAnswers: (json['wrong_answers'] as num).toInt(),
  score: (json['score'] as num).toDouble(),
  durationSeconds: (json['duration_seconds'] as num).toInt(),
  resultTestMode: ResultModel._resultTestModeFromJson(
    json['is_test_mode'] as bool?,
  ),
  questionAnswers:
      json['question_answers'] == null
          ? []
          : ResultModel._questionAnswersFromJson(
            json['question_answers'] as List?,
          ),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ResultModelToJson(
  ResultModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'lesson_id': instance.lessonId,
  'lesson_title': instance.lessonTitle,
  'user_rank': instance.resultOrder,
  'total_questions': instance.totalQuestions,
  'correct_answers': instance.correctAnswers,
  'wrong_answers': instance.wrongAnswers,
  'score': instance.score,
  'duration_seconds': instance.durationSeconds,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'is_test_mode': ResultModel._resultTestModeToJson(instance.resultTestMode),
  'question_answers': ResultModel._questionAnswersToJson(
    instance.questionAnswers,
  ),
};
