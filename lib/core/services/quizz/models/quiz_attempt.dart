import 'package:bac_project/core/services/quizz/models/attempt_status.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';

class QuizAttempt {
  const QuizAttempt({
    required this.quizId,
    required this.status,
    required this.orderedQuestions,
    required this.currentIndex,
    required this.answers,
    required this.startedAt,
    this.submittedAt,
    required this.elapsed,
  });

  final int quizId;
  final AttemptStatus status;

  final List<Question> orderedQuestions;
  final int currentIndex;

  /// All answers recorded for this attempt.
  ///
  /// For multiple-choice questions, multiple entries can share the same
  /// questionId (one per selected option).
  final List<QuestionAnswer> answers;

  final DateTime startedAt;
  final DateTime? submittedAt;
  final Duration elapsed;

  int get totalQuestions => orderedQuestions.length;

  Question get currentQuestion => orderedQuestions[currentIndex];

  bool get isFirstQuestion => currentIndex == 0;

  bool get isLastQuestion => currentIndex == totalQuestions - 1;

  int get answeredCount => answers.map((a) => a.questionId).toSet().length;

  double get progress => totalQuestions > 0 ? answeredCount / totalQuestions : 0.0;

  List<QuestionAnswer> answersForQuestion(int questionId) {
    return answers.where((a) => a.questionId == questionId).toList();
  }

  bool isQuestionAnswered(int questionId) {
    return answers.any((a) => a.questionId == questionId);
  }

  QuizAttempt copyWith({
    int? quizId,
    AttemptStatus? status,
    List<Question>? orderedQuestions,
    int? currentIndex,
    List<QuestionAnswer>? answers,
    DateTime? startedAt,
    DateTime? submittedAt,
    Duration? elapsed,
  }) {
    return QuizAttempt(
      quizId: quizId ?? this.quizId,
      status: status ?? this.status,
      orderedQuestions: orderedQuestions ?? this.orderedQuestions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      startedAt: startedAt ?? this.startedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      elapsed: elapsed ?? this.elapsed,
    );
  }
}
