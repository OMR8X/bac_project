import 'dart:math';

import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';

import 'user_answer.dart';
import 'result_test_mode.dart';

class Result {
  // Identification
  final int id;
  final String userId;
  // Test Source
  final int? lessonId;
  final String? lessonTitle;
  final int? resultOrder;
  // Performance Metrics
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double score;
  final int durationSeconds;
  final ResultTestMode? resultTestMode;
  // User Answers
  final List<ResultAnswer> answers;
  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  const Result({
    required this.id,
    required this.userId,
    this.lessonId,
    this.lessonTitle,
    this.resultOrder,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
    required this.durationSeconds,
    this.resultTestMode,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.random() {
    return Result(
      id: 1,
      userId: '1',
      lessonId: 1,
      lessonTitle: 'اختبار مخصص',
      totalQuestions: 1,
      correctAnswers: Random().nextInt(100),
      wrongAnswers: Random().nextInt(100),
      score: Random().nextDouble(),
      durationSeconds: Random().nextInt(100),
      resultTestMode: ResultTestMode.testing,
      answers: [],
      createdAt: DateTime.now().add(Duration(days: -Random().nextInt(100))),
      updatedAt: DateTime.now().add(Duration(days: -Random().nextInt(100))),
    );
  }

  Result copyWith({
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
    List<ResultAnswer>? answers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Result(
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
      resultTestMode: resultTestMode ?? this.resultTestMode, // Add this line
      answers: answers ?? this.answers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result &&
        other.id == id &&
        other.userId == userId &&
        other.lessonId == lessonId &&
        other.lessonTitle == lessonTitle &&
        other.resultOrder == resultOrder &&
        other.totalQuestions == totalQuestions &&
        other.correctAnswers == correctAnswers &&
        other.wrongAnswers == wrongAnswers &&
        other.score == score &&
        other.durationSeconds == durationSeconds &&
        other.resultTestMode == resultTestMode && // Add this line
        other.answers == answers &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      (lessonId?.hashCode ?? 0) ^
      (lessonTitle?.hashCode ?? 0) ^
      (resultOrder?.hashCode ?? 0) ^
      totalQuestions.hashCode ^
      correctAnswers.hashCode ^
      wrongAnswers.hashCode ^
      score.hashCode ^
      durationSeconds.hashCode ^
      (resultTestMode?.hashCode ?? 0) ^ // Add this line
      answers.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() =>
      'Result(id: $id, userId: $userId, lessonId: $lessonId, lessonTitle: $lessonTitle, resultOrder: $resultOrder, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, score: $score, durationSeconds: $durationSeconds, resultTestMode: $resultTestMode, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt)';
}
