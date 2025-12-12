import 'dart:async';

import 'package:bac_project/core/services/quizz/models/models.dart';
import 'package:bac_project/core/services/quizz/quizzing_manager.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';

typedef SubmitAttemptHandler = Future<Result> Function(QuizAttempt attempt);

class QuizzingManagerImplementation implements QuizzingManager {
  QuizzingManagerImplementation({
    required SubmitAttemptHandler submitAttempt,
    DateTime Function()? now,
  }) : _submitAttempt = submitAttempt,
       _now = now ?? DateTime.now;

  final SubmitAttemptHandler _submitAttempt;
  final DateTime Function() _now;

  Quiz? _quiz;
  QuizConfiguration? _configuration;

  void _ensureInitialized() {
    if (_quiz == null || _configuration == null) {
      throw StateError('QuizzingManagerImplementation.start must be called first.');
    }
  }

  @override
  QuizAttempt start(Quiz quiz) {
    _quiz = quiz;
    _configuration = quiz.configuration;

    return QuizAttempt(
      quizId: quiz.id,
      status: AttemptStatus.inProgress,
      orderedQuestions: quiz.questions,
      currentIndex: 0,
      answers: const [],
      startedAt: _now(),
      submittedAt: null,
      elapsed: Duration.zero,
    );
  }

  @override
  QuizAttempt goToQuestion(QuizAttempt attempt, int index) {
    _ensureInitialized();
    if (index < 0 || index >= attempt.totalQuestions) {
      return attempt;
    }
    return attempt.copyWith(currentIndex: index);
  }

  @override
  QuizAttempt goNext(QuizAttempt attempt) {
    _ensureInitialized();
    if (!canGoNext(attempt, _configuration!)) {
      return attempt;
    }
    return attempt.copyWith(currentIndex: attempt.currentIndex + 1);
  }

  @override
  QuizAttempt goPrevious(QuizAttempt attempt) {
    _ensureInitialized();
    if (!canGoPrevious(attempt, _configuration!)) {
      return attempt;
    }
    return attempt.copyWith(currentIndex: attempt.currentIndex - 1);
  }

  @override
  QuizAttempt recordAnswer(
    QuizAttempt attempt, {
    required int questionId,
    List<int>? selectedOptionIds,
    String? answerText,
  }) {
    _ensureInitialized();
    final configuration = _configuration!;

    if (!canChangeAnswer(attempt, configuration, questionId) &&
        attempt.isQuestionAnswered(questionId)) {
      return attempt;
    }

    final question = _quiz!.questions.firstWhere(
      (q) => q.id == questionId,
      orElse: () => throw StateError('Question $questionId not found in quiz.'),
    );

    final filteredAnswers = attempt.answers.where((a) => a.questionId != questionId).toList();

    final List<QuestionAnswer> newAnswers = switch (question.type) {
      QuestionType.multipleChoice => [
        ...filteredAnswers,
        if (selectedOptionIds != null)
          ...selectedOptionIds.map(
            (optionId) => QuestionAnswer(
              questionId: questionId,
              optionId: optionId,
              answerText: null,
            ),
          ),
      ],
      QuestionType.trueFalse || QuestionType.singleChoice || null => [
        ...filteredAnswers,
        if (selectedOptionIds != null && selectedOptionIds.isNotEmpty)
          QuestionAnswer(
            questionId: questionId,
            optionId: selectedOptionIds.first,
            answerText: null,
          ),
      ],
      QuestionType.textEntry => [
        ...filteredAnswers,
        QuestionAnswer(
          questionId: questionId,
          optionId: null,
          answerText: answerText,
        ),
      ],
    };

    return attempt.copyWith(answers: newAnswers);
  }

  @override
  QuizAttempt clearAnswer(QuizAttempt attempt, int questionId) {
    _ensureInitialized();
    if (!canChangeAnswer(attempt, _configuration!, questionId)) {
      return attempt;
    }
    final updatedAnswers = attempt.answers.where((a) => a.questionId != questionId).toList();
    return attempt.copyWith(answers: updatedAnswers);
  }

  @override
  QuizAttempt tick(QuizAttempt attempt, Duration elapsed) {
    _ensureInitialized();
    final updated = attempt.copyWith(elapsed: elapsed);

    if (isTimeExpired(updated, _configuration!)) {
      return updated.copyWith(status: AttemptStatus.expired);
    }
    return updated;
  }

  @override
  Future<Result> submit(QuizAttempt attempt) async {
    _ensureInitialized();
    final updated = attempt.copyWith(
      status: AttemptStatus.submitting,
      submittedAt: _now(),
    );
    final result = await _submitAttempt(updated);
    return result;
  }

  @override
  bool canGoNext(QuizAttempt attempt, QuizConfiguration configuration) {
    final nextIndex = attempt.currentIndex + 1;
    return nextIndex < attempt.totalQuestions && !isTimeExpired(attempt, configuration);
  }

  @override
  bool canGoPrevious(QuizAttempt attempt, QuizConfiguration configuration) {
    return configuration.allowBacktrack &&
        attempt.currentIndex - 1 >= 0 &&
        !isTimeExpired(attempt, configuration);
  }

  @override
  bool canChangeAnswer(
    QuizAttempt attempt,
    QuizConfiguration configuration,
    int questionId,
  ) {
    if (!configuration.allowChangeAnswer) {
      return !attempt.isQuestionAnswered(questionId);
    }
    return !isTimeExpired(attempt, configuration);
  }

  @override
  Duration? remainingTime(
    QuizAttempt attempt,
    QuizConfiguration configuration,
  ) {
    final overall = configuration.overallTimeLimit;
    if (overall == null) return null;
    final remaining = overall - attempt.elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  @override
  bool isTimeExpired(QuizAttempt attempt, QuizConfiguration configuration) {
    final remaining = remainingTime(attempt, configuration);
    if (remaining == null) return false;
    return remaining <= Duration.zero;
  }
}
