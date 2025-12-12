import 'package:bac_project/core/services/quizz/models/models.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';

abstract class QuizzingManager {
  /// Start a new quiz attempt.
  QuizAttempt start(Quiz quiz);

  /// Go to a specific question index.
  QuizAttempt goToQuestion(QuizAttempt attempt, int index);

  /// Move to the next question if allowed.
  QuizAttempt goNext(QuizAttempt attempt);

  /// Move to the previous question if allowed by configuration.
  QuizAttempt goPrevious(QuizAttempt attempt);

  /// Record an answer for a question.
  ///
  /// - For single choice / true-false: pass one option id in [selectedOptionIds].
  /// - For multiple choice: pass multiple option ids.
  /// - For text entry: pass [answerText].
  QuizAttempt recordAnswer(
    QuizAttempt attempt, {
    required int questionId,
    List<int>? selectedOptionIds,
    String? answerText,
  });

  /// Clear an answer for a question (if allowed by configuration).
  QuizAttempt clearAnswer(QuizAttempt attempt, int questionId);

  /// Update elapsed time (typically called by a timer tick).
  QuizAttempt tick(QuizAttempt attempt, Duration elapsed);

  /// Submit the quiz and return a Result.
  Future<Result> submit(QuizAttempt attempt);

  /// ---- Query helpers ----
  bool canGoNext(QuizAttempt attempt, QuizConfiguration configuration);

  bool canGoPrevious(QuizAttempt attempt, QuizConfiguration configuration);

  bool canChangeAnswer(
    QuizAttempt attempt,
    QuizConfiguration configuration,
    int questionId,
  );

  Duration? remainingTime(QuizAttempt attempt, QuizConfiguration configuration);

  bool isTimeExpired(QuizAttempt attempt, QuizConfiguration configuration);
}
