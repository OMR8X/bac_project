import '../../domain/entities/result.dart';
import '../../domain/entities/user_answer.dart';
import 'user_answer_model.dart';

class ResultModel extends Result {
  const ResultModel({
    required super.id,
    required super.userId,
    super.lessonId,
    super.lessonTitle,
    super.questionsIds,
    super.resultOrder,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.skippedAnswers,
    required super.score,
    required super.durationSeconds,
    required super.answers,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      lessonId: json['lesson_id'] as int?,
      lessonTitle: json['lesson_title'] as String?,
      questionsIds:
          json['questions_ids'] != null
              ? List<int>.from(json['questions_ids'] as List<dynamic>)
              : null,
      resultOrder: json['result_order'] as int?,
      totalQuestions: json['total_questions'] as int,
      correctAnswers: json['correct_answers'] as int,
      wrongAnswers: json['wrong_answers'] as int,
      skippedAnswers: json['skipped_answers'] as int,
      score: (json['score'] as num).toDouble(),
      durationSeconds: json['duration_seconds'] as int,
      answers:
          (json['answers'] as List<dynamic>)
              .map(
                (a) => UserAnswerModel.fromJson(
                  a as Map<String, dynamic>,
                ),
              )
              .toList(),
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
      'questions_ids': questionsIds,
      'total_questions': totalQuestions,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'skipped_answers': skippedAnswers,
      'score': score,
      'duration_seconds': durationSeconds,
      'answers':
          answers
              .map((a) => (a as UserAnswerModel).toJson())
              .toList(),
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
    List<int>? questionsIds,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    int? skippedAnswers,
    double? score,
    int? durationSeconds,
    List<UserAnswer>? answers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ResultModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      questionsIds: questionsIds ?? this.questionsIds,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      skippedAnswers: skippedAnswers ?? this.skippedAnswers,
      score: score ?? this.score,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      answers: answers ?? this.answers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
