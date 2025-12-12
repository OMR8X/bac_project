import 'package:bac_project/core/services/quizz/models/attempt_status.dart';
import 'package:bac_project/core/services/quizz/models/quiz_attempt.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Question _question(int id) => Question(
    id: id,
    content: 'Q$id',
    options: const [],
    lessonId: 1,
  );

  QuizAttempt _attempt({
    int quizId = 1,
    AttemptStatus status = AttemptStatus.inProgress,
    List<Question>? questions,
    int currentIndex = 0,
    List<QuestionAnswer> answers = const [],
    Duration elapsed = Duration.zero,
  }) {
    final q =
        questions ??
        [
          _question(1),
          _question(2),
          _question(3),
        ];
    return QuizAttempt(
      quizId: quizId,
      status: status,
      orderedQuestions: q,
      currentIndex: currentIndex,
      answers: answers,
      startedAt: DateTime(2024),
      submittedAt: null,
      elapsed: elapsed,
    );
  }

  group('QuizAttempt helpers', () {
    test('computed properties: totals, flags, progress', () {
      final attempt = _attempt(
        answers: const [
          QuestionAnswer(questionId: 1, optionId: 10),
          QuestionAnswer(questionId: 2, optionId: 20),
        ],
        currentIndex: 1,
      );

      expect(attempt.totalQuestions, 3);
      expect(attempt.isFirstQuestion, isFalse);
      expect(attempt.isLastQuestion, isFalse);
      expect(attempt.progress, closeTo(2 / 3, 0.0001));
    });

    test('answersForQuestion and isQuestionAnswered', () {
      final attempt = _attempt(
        answers: const [
          QuestionAnswer(questionId: 2, optionId: 20),
          QuestionAnswer(questionId: 2, optionId: 21),
        ],
      );

      final answers = attempt.answersForQuestion(2);
      expect(answers, hasLength(2));
      expect(attempt.isQuestionAnswered(2), isTrue);
      expect(attempt.isQuestionAnswered(3), isFalse);
    });

    test('progress is zero when no questions', () {
      final attempt = _attempt(questions: const []);
      expect(attempt.totalQuestions, 0);
      expect(attempt.progress, 0.0);
    });
  });
}
