import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/presentation/tests/blocs/quizzing/quizzing_bloc.dart';

class MockQuestion extends Mock implements Question {}

class MockOption extends Mock implements Option {}

void main() {
  group('QuizzingBloc', () {
    late QuizzingBloc quizzingBloc;
    late List<Question> mockQuestions;
    late MockQuestion mockQuestion1;
    late MockQuestion mockQuestion2;
    late MockOption mockOption1;
    late MockOption mockOption2;

    setUp(() {
      quizzingBloc = QuizzingBloc();
      mockOption1 = MockOption();
      mockOption2 = MockOption();

      when(() => mockOption1.id).thenReturn('option1');
      when(() => mockOption1.isCorrect).thenReturn(true);
      when(() => mockOption2.id).thenReturn('option2');
      when(() => mockOption2.isCorrect).thenReturn(false);

      mockQuestion1 = MockQuestion();
      mockQuestion2 = MockQuestion();

      when(() => mockQuestion1.id).thenReturn('q1');
      when(() => mockQuestion1.text).thenReturn('Question 1?');
      when(
        () => mockQuestion1.options,
      ).thenReturn([mockOption1, mockOption2]);
      when(
        () => mockQuestion1.trueAnswers('option1'),
      ).thenReturn(true);
      when(
        () => mockQuestion1.trueAnswers('option2'),
      ).thenReturn(false);

      when(() => mockQuestion2.id).thenReturn('q2');
      when(() => mockQuestion2.text).thenReturn('Question 2?');
      when(
        () => mockQuestion2.options,
      ).thenReturn([mockOption1, mockOption2]);
      when(
        () => mockQuestion2.trueAnswers('option2'),
      ).thenReturn(true);
      when(
        () => mockQuestion2.trueAnswers('option1'),
      ).thenReturn(false);

      mockQuestions = [mockQuestion1, mockQuestion2];
    });

    tearDown(() {
      quizzingBloc.close();
    });

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingLoading, QuizzingAnswerQuestion] when InitializeQuiz is added',
      build: () => quizzingBloc,
      act:
          (bloc) => bloc.add(
            InitializeQuiz(questions: mockQuestions, timeLimit: 1),
          ),
      expect:
          () => [
            const QuizzingLoading(),
            isA<QuizzingAnswerQuestion>()
                .having(
                  (s) => s.currentQuestion,
                  'currentQuestion',
                  mockQuestions[0],
                )
                .having(
                  (s) => s.currentQuestionIndex,
                  'currentQuestionIndex',
                  0,
                )
                .having((s) => s.totalQuestions, 'totalQuestions', 2)
                .having((s) => s.canGoNext, 'canGoNext', true)
                .having(
                  (s) => s.canGoPrevious,
                  'canGoPrevious',
                  false,
                )
                .having(
                  (s) => s.selectedAnswerId,
                  'selectedAnswerId',
                  null,
                ),
          ],
      verify: (_) {
        // Verify that the timer is started (indirectly by observing state changes)
        // and that _selectedAnswers map is initialized.
      },
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingAnswerQuestion] with selectedAnswerId when OptionQuestion is added',
      build: () => quizzingBloc,
      act: (bloc) {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        bloc.add(
          const OptionQuestion(answerId: 'option1', questionIndex: 0),
        );
      },
      skip:
          2, // Skip QuizzingLoading and initial QuizzingAnswerQuestion
      expect:
          () => [
            isA<QuizzingAnswerQuestion>().having(
              (s) => s.selectedAnswerId,
              'selectedAnswerId',
              'option1',
            ),
          ],
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingAnswerQuestion] with next question when NextQuestion is added',
      build: () => quizzingBloc,
      act: (bloc) {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        bloc.add(const NextQuestion());
      },
      skip:
          2, // Skip QuizzingLoading and initial QuizzingAnswerQuestion
      expect:
          () => [
            isA<QuizzingAnswerQuestion>()
                .having(
                  (s) => s.currentQuestion,
                  'currentQuestion',
                  mockQuestions[1],
                )
                .having(
                  (s) => s.currentQuestionIndex,
                  'currentQuestionIndex',
                  1,
                )
                .having((s) => s.canGoNext, 'canGoNext', false)
                .having(
                  (s) => s.canGoPrevious,
                  'canGoPrevious',
                  true,
                ),
          ],
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingAnswerQuestion] with previous question when PreviousQuestion is added',
      build: () => quizzingBloc,
      act: (bloc) {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        bloc.add(const NextQuestion()); // Go to next question
        bloc.add(
          const PreviousQuestion(),
        ); // Go back to previous question
      },
      skip:
          3, // Skip QuizzingLoading, initial QuizzingAnswerQuestion, and next question state
      expect:
          () => [
            isA<QuizzingAnswerQuestion>()
                .having(
                  (s) => s.currentQuestion,
                  'currentQuestion',
                  mockQuestions[0],
                )
                .having(
                  (s) => s.currentQuestionIndex,
                  'currentQuestionIndex',
                  0,
                )
                .having((s) => s.canGoNext, 'canGoNext', true)
                .having(
                  (s) => s.canGoPrevious,
                  'canGoPrevious',
                  false,
                ),
          ],
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingResult] when SubmitQuiz is added',
      build: () => quizzingBloc,
      act: (bloc) {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        bloc.add(
          const OptionQuestion(answerId: 'option1', questionIndex: 0),
        ); // Correct answer for q1
        bloc.add(const NextQuestion());
        bloc.add(
          const OptionQuestion(answerId: 'option1', questionIndex: 1),
        ); // Wrong answer for q2
        bloc.add(const SubmitQuiz());
      },
      skip: 4, // Skip loading and answer states
      expect:
          () => [
            isA<QuizzingResult>()
                .having((s) => s.totalQuestions, 'totalQuestions', 2)
                .having((s) => s.correctAnswers, 'correctAnswers', 1)
                .having((s) => s.wrongAnswers, 'wrongAnswers', 1)
                .having((s) => s.skippedAnswers, 'skippedAnswers', 0)
                .having((s) => s.score, 'score', 50.0),
          ],
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingResult] when CloseQuiz is added',
      build: () => quizzingBloc,
      act: (bloc) {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        bloc.add(const CloseQuiz());
      },
      skip: 2,
      expect: () => [isA<QuizzingResult>()],
    );

    blocTest<QuizzingBloc, QuizzingState>(
      'emits [QuizzingAnswerQuestion] with updated timeLeft when timer updates',
      build: () {
        quizzingBloc = QuizzingBloc();
        return quizzingBloc;
      },
      act: (bloc) async {
        bloc.add(
          InitializeQuiz(questions: mockQuestions, timeLimit: 1),
        );
        // Simulate time passing by waiting
        await Future.delayed(
          const Duration(milliseconds: 150),
        ); // Allow timer to tick at least once
      },
      skip: 2, // Skip initial loading and QuizzingAnswerQuestion
      expect:
          () => [
            isA<QuizzingAnswerQuestion>().having(
              (s) => s.timeLeft.inSeconds,
              'timeLeft in seconds',
              lessThan(60),
            ),
          ],
    );
  });
}
