import 'package:bac_project/features/tests/data/mappers/question_answer_mapper.dart';
import 'package:bac_project/features/tests/data/mappers/question_mapper.dart';
import 'package:bac_project/features/tests/data/models/question_answer_model.dart';
import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/results/domain/entities/result_test_mode.dart';

import '../../domain/entities/result.dart';

class ResultModel extends Result {
  const ResultModel({
    required super.id,
    required super.userId,
    super.lessonId,
    super.lessonTitle,
    super.resultOrder,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.score,
    required super.durationSeconds,
    super.resultTestMode,
    required super.questionAnswers,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      lessonId: json['lesson_id'] as int?,
      lessonTitle: json['lesson_title'] as String?,
      resultOrder: json['result_order'] as int?,
      totalQuestions: json['total_questions'] as int,
      correctAnswers: json['correct_answers'] as int,
      wrongAnswers: json['wrong_answers'] as int,
      score: (json['score'] as num).toDouble(),
      durationSeconds: json['duration_seconds'] as int,
      resultTestMode:
          json['result_test_mode'] == null
              ? null
              : ResultTestMode.values.byName(json['result_test_mode'] as String),
      questionAnswers:
          (json['question_answers'] as List<dynamic>?)
              ?.map((a) => QuestionAnswerModel.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'lesson_id': lessonId,
      'lesson_title': lessonTitle,
      'result_order': resultOrder,
      'total_questions': totalQuestions,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'score': score,
      'duration_seconds': durationSeconds,
      'result_test_mode': resultTestMode?.name,
      'question_answers': questionAnswers.map((a) => (a.toModel().toJson())).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  ResultModel copyWith({
    int? id,
    String? userId,
    int? lessonId,
    String? lessonTitle,
    int? resultOrder,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    double? score,
    int? durationSeconds,
    ResultTestMode? resultTestMode,
    List<QuestionAnswer>? questionAnswers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ResultModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      resultOrder: resultOrder ?? this.resultOrder,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      score: score ?? this.score,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      resultTestMode: resultTestMode ?? this.resultTestMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
