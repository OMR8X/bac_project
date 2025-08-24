import 'user_answer.dart';

class Result {
  // Identification
  final int id;
  final String userId;
  // Test Source
  final int? lessonId;
  final String? lessonTitle;
  final List<int>? questionsIds;
  // Performance Metrics
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double score;
  final int durationSeconds;
  // User Answers
  final List<UserAnswer> answers;
  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  const Result({
    required this.id,
    required this.userId,
    this.lessonId,
    this.lessonTitle,
    this.questionsIds,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
    required this.durationSeconds,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  Result copyWith({
    int? id,
    String? userId,
    int? lessonId,
    String? lessonTitle,
    List<int>? questionsIds,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    double? score,
    int? durationSeconds,
    List<UserAnswer>? answers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Result(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      questionsIds: questionsIds ?? this.questionsIds,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      score: score ?? this.score,
      durationSeconds: durationSeconds ?? this.durationSeconds,
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
        other.questionsIds == questionsIds &&
        other.totalQuestions == totalQuestions &&
        other.correctAnswers == correctAnswers &&
        other.wrongAnswers == wrongAnswers &&
        other.score == score &&
        other.durationSeconds == durationSeconds &&
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
      (questionsIds?.hashCode ?? 0) ^
      totalQuestions.hashCode ^
      correctAnswers.hashCode ^
      wrongAnswers.hashCode ^
      score.hashCode ^
      durationSeconds.hashCode ^
      answers.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() =>
      'Result(id: $id, userId: $userId, lessonId: $lessonId, lessonTitle: $lessonTitle, questionsIds: $questionsIds, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, score: $score, durationSeconds: $durationSeconds, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt)';
}
