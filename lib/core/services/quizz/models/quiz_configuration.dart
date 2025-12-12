import 'package:bac_project/core/services/quizz/models/correctness_visibility.dart';

class QuizConfiguration {
  const QuizConfiguration({
    this.allowBacktrack = true,
    this.allowChangeAnswer = true,
    this.correctnessVisibility = CorrectnessVisibility.afterSubmit,
    this.overallTimeLimit,
    this.perQuestionTimeLimit,
    this.autoSubmitOnTimeout = false,
    // this.shuffleQuestions,
    // this.shuffleOptions,
  });

  final bool allowBacktrack;
  final bool allowChangeAnswer;
  final CorrectnessVisibility correctnessVisibility;
  final Duration? overallTimeLimit;
  final Duration? perQuestionTimeLimit;
  final bool autoSubmitOnTimeout;

  // final bool? shuffleQuestions;
  // final bool? shuffleOptions;

  QuizConfiguration copyWith({
    bool? allowBacktrack,
    bool? allowChangeAnswer,
    CorrectnessVisibility? correctnessVisibility,
    Duration? overallTimeLimit,
    Duration? perQuestionTimeLimit,
    bool? autoSubmitOnTimeout,
    // bool? shuffleQuestions,
    // bool? shuffleOptions,
  }) {
    return QuizConfiguration(
      allowBacktrack: allowBacktrack ?? this.allowBacktrack,
      allowChangeAnswer: allowChangeAnswer ?? this.allowChangeAnswer,
      correctnessVisibility: correctnessVisibility ?? this.correctnessVisibility,
      overallTimeLimit: overallTimeLimit ?? this.overallTimeLimit,
      perQuestionTimeLimit: perQuestionTimeLimit ?? this.perQuestionTimeLimit,
      autoSubmitOnTimeout: autoSubmitOnTimeout ?? this.autoSubmitOnTimeout,
      // shuffleQuestions: shuffleQuestions ?? this.shuffleQuestions,
      // shuffleOptions: shuffleOptions ?? this.shuffleOptions,
    );
  }
}
