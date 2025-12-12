# Quiz System (Core, UI-agnostic)

This module provides the quiz lifecycle, navigation, timing, and answer handling. It reuses existing domain entities (`Question`, `Option`, `QuestionAnswer`, `Result`, `AnswerEvaluation`) and adds a small set of quiz-specific models plus a manager implementation.

## Files
- `models/question_type.dart` — discriminates question rendering/handling.
- `models/correctness_visibility.dart` — when to reveal correctness.
- `models/attempt_status.dart` — lifecycle of an attempt.
- `models/quiz_configuration.dart` — navigation/visibility/timing settings.
- `models/quiz.dart` — quiz data + configuration (description/source repo placeholders were removed per request).
- `models/quiz_attempt.dart` — runtime state (ordered questions, answers, timers).
- `models/models.dart` — barrel export.
- `quizzing_manager.dart` — abstract API for quiz control.
- `quizzing_manager_implementation.dart` — default implementation (inject submission handler).

## Models (summary)
- `QuestionType`: `singleChoice`, `multipleChoice`, `trueFalse`, `textEntry` (future: matching/ordering).
- `QuizConfiguration`: `allowBacktrack`, `allowChangeAnswer`, `correctnessVisibility`, `overallTimeLimit`, `perQuestionTimeLimit`, `autoSubmitOnTimeout`. Shuffle flags are commented placeholders.
- `Quiz`: `id`, `title`, `questions: List<Question>`, `configuration: QuizConfiguration`.
- `QuizAttempt`: `quizId`, `status`, `orderedQuestions`, `currentIndex`, `answers: List<QuestionAnswer>`, `startedAt`, `submittedAt`, `elapsed`; helpers: `progress`, `answersForQuestion`, `isQuestionAnswered`, `isFirstQuestion`, `isLastQuestion`.

## Manager API (core ideas)
- `start(Quiz)` → `QuizAttempt`
- Navigation: `goToQuestion`, `goNext`, `goPrevious`
- Answering: `recordAnswer(questionId, selectedOptionIds?, answerText?)`, `clearAnswer`
- Timing: `tick(elapsed)` updates elapsed; `remainingTime`, `isTimeExpired`
- Submission: `submit(attempt)` delegates to injected `SubmitAttemptHandler`
- Guards: `canGoNext`, `canGoPrevious`, `canChangeAnswer`

## Answer handling rules
- `QuestionType.multipleChoice`: one `QuestionAnswer` per selected option.
- `QuestionType.singleChoice`/`trueFalse`: replaces with a single `QuestionAnswer` using the first `selectedOptionIds` entry.
- `QuestionType.textEntry`: stores `answerText`.
- Forbid changes when `allowChangeAnswer` is false and the question already has answers.

## Timing rules
- `overallTimeLimit`/`perQuestionTimeLimit` supported via `tick` + `isTimeExpired`.
- Current implementation marks status `expired` when time runs out; auto-submit behavior can be added by caller/handler if desired.

## Submission
- `QuizzingManagerImplementation` calls the injected `SubmitAttemptHandler` with the current `QuizAttempt`. The handler should map `QuestionAnswer` entries to the backend request and return a `Result` (which already holds `questionAnswers` and scoring fields).

## Extensibility hooks
- Matching/ordering: add to `QuestionType` and extend `recordAnswer` handling.
- Shuffle: uncomment flags in `QuizConfiguration` and apply when constructing `QuizAttempt.orderedQuestions`.
- Persistence: add `toJson/fromJson` to `QuizAttempt` when offline retry is needed.

## Integration steps (typical)
1) Build `Quiz` from backend payload (including `Question.type`).
2) `final attempt = manager.start(quiz);`
3) Drive UI with `attempt.currentQuestion`, `canGoNext`, `canGoPrevious`, `remainingTime`.
4) Record answers via `recordAnswer`; respect `canChangeAnswer`.
5) Update timers via `tick`.
6) On finish, call `submit` and display the returned `Result`/evaluations. Discard the attempt unless retrying.
