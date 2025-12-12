import 'dart:async';

import 'package:bac_project/core/services/quizz/models/models.dart';
import 'package:bac_project/core/services/quizz/quizzing_manager_implementation.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Quiz _quiz({
    QuizConfiguration configuration = const QuizConfiguration(),
    List<Question>? questions,
  }) {
    final qs =
        questions ??
        [
          Question(
            id: 1,
            content: 'Q1',
            options: const [
              Option(id: 11, questionId: 1, content: 'A', isCorrect: false),
            ],
            lessonId: 1,
            type: QuestionType.singleChoice,
          ),
          Question(
            id: 2,
            content: 'Q2',
            options: const [
              Option(id: 21, questionId: 2, content: 'A', isCorrect: false),
              Option(id: 22, questionId: 2, content: 'B', isCorrect: false),
            ],
            lessonId: 1,
            type: QuestionType.multipleChoice,
          ),
          Question(
            id: 3,
            content: 'Q3',
            options: const [],
            lessonId: 1,
            type: QuestionType.textEntry,
          ),
        ];
    return Quiz(
      id: 1,
      title: 'Quiz',
      questions: qs,
      configuration: configuration,
    );
  }

  Result _dummyResult() => Result(
    id: 1,
    userId: 'u1',
    totalQuestions: 1,
    correctAnswers: 1,
    wrongAnswers: 0,
    score: 1.0,
    durationSeconds: 10,
    questionAnswers: const [],
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );

  group('QuizzingManagerImplementation', () {
    test('start initializes attempt', () {
      late QuizAttempt attempt;
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );

      attempt = manager.start(_quiz());

      expect(attempt.quizId, 1);
      expect(attempt.currentIndex, 0);
      expect(attempt.answers, isEmpty);
      expect(attempt.status, AttemptStatus.inProgress);
    });

    test('navigation respects bounds and allowBacktrack', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz(
        configuration: const QuizConfiguration(allowBacktrack: false),
      );
      var attempt = manager.start(quiz);

      attempt = manager.goPrevious(attempt);
      expect(attempt.currentIndex, 0); // no back when at start or backtrack off

      attempt = manager.goNext(attempt);
      expect(attempt.currentIndex, 1);

      attempt = manager.goPrevious(attempt);
      expect(attempt.currentIndex, 1); // backtrack disabled
    });

    test('recordAnswer handles singleChoice, multipleChoice, trueFalse, textEntry', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz();
      var attempt = manager.start(quiz);

      // singleChoice / trueFalse (treated the same)
      attempt = manager.recordAnswer(
        attempt,
        questionId: 1,
        selectedOptionIds: const [11],
      );
      expect(attempt.answers, hasLength(1));
      expect(attempt.answers.first.optionId, 11);

      // multipleChoice
      attempt = manager.recordAnswer(
        attempt,
        questionId: 2,
        selectedOptionIds: const [21, 22],
      );
      final q2Answers = attempt.answers.where((a) => a.questionId == 2).toList();
      expect(q2Answers, hasLength(2));
      expect(q2Answers.map((a) => a.optionId), containsAll([21, 22]));

      // textEntry
      attempt = manager.recordAnswer(
        attempt,
        questionId: 3,
        answerText: 'typed',
      );
      final q3Answers = attempt.answers.where((a) => a.questionId == 3).toList();
      expect(q3Answers.single.answerText, 'typed');
    });

    test('recordAnswer respects allowChangeAnswer=false after first answer', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz(
        configuration: const QuizConfiguration(allowChangeAnswer: false),
      );
      var attempt = manager.start(quiz);

      attempt = manager.recordAnswer(
        attempt,
        questionId: 1,
        selectedOptionIds: const [11],
      );
      expect(attempt.answers.single.optionId, 11);

      // Second attempt to change should be ignored
      attempt = manager.recordAnswer(
        attempt,
        questionId: 1,
        selectedOptionIds: const [999],
      );
      expect(attempt.answers.single.optionId, 11);
    });

    test('clearAnswer removes answers when allowed', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz();
      var attempt = manager.start(quiz);

      attempt = manager.recordAnswer(
        attempt,
        questionId: 1,
        selectedOptionIds: const [11],
      );
      expect(attempt.answers, isNotEmpty);

      attempt = manager.clearAnswer(attempt, 1);
      expect(attempt.answers.where((a) => a.questionId == 1), isEmpty);
    });

    test('tick updates elapsed and marks expired', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz(
        configuration: const QuizConfiguration(
          overallTimeLimit: Duration(seconds: 5),
        ),
      );
      var attempt = manager.start(quiz);

      attempt = manager.tick(attempt, const Duration(seconds: 3));
      expect(attempt.elapsed, const Duration(seconds: 3));
      expect(attempt.status, AttemptStatus.inProgress);

      attempt = manager.tick(attempt, const Duration(seconds: 6));
      expect(attempt.status, AttemptStatus.expired);
    });

    test('remainingTime and isTimeExpired without limit return null/false', () {
      final manager = QuizzingManagerImplementation(
        submitAttempt: (_) async => _dummyResult(),
      );
      final quiz = _quiz(
        configuration: const QuizConfiguration(
          overallTimeLimit: null,
        ),
      );
      var attempt = manager.start(quiz);

      expect(manager.remainingTime(attempt, quiz.configuration), isNull);
      expect(manager.isTimeExpired(attempt, quiz.configuration), isFalse);
    });

    test('submit calls handler and returns result', () async {
      QuizAttempt? receivedAttempt;
      final manager = QuizzingManagerImplementation(
        submitAttempt: (attempt) async {
          receivedAttempt = attempt;
          return _dummyResult();
        },
      );
      final quiz = _quiz();
      final attempt = manager.start(quiz);

      final result = await manager.submit(attempt);

      expect(receivedAttempt, isNotNull);
      expect(receivedAttempt!.status, AttemptStatus.submitting);
      expect(result.userId, 'u1');
    });
  });
}
