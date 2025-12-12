import 'package:bac_project/core/services/quizz/models/correctness_visibility.dart';
import 'package:bac_project/core/services/quizz/models/quiz_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizConfiguration', () {
    test('defaults are set', () {
      const config = QuizConfiguration();
      expect(config.allowBacktrack, isTrue);
      expect(config.allowChangeAnswer, isTrue);
      expect(config.correctnessVisibility, CorrectnessVisibility.afterSubmit);
      expect(config.overallTimeLimit, isNull);
      expect(config.perQuestionTimeLimit, isNull);
      expect(config.autoSubmitOnTimeout, isFalse);
    });

    test('copyWith overrides only provided values', () {
      const original = QuizConfiguration(
        allowBacktrack: true,
        allowChangeAnswer: true,
        correctnessVisibility: CorrectnessVisibility.afterSubmit,
        overallTimeLimit: Duration(minutes: 10),
        perQuestionTimeLimit: Duration(seconds: 30),
        autoSubmitOnTimeout: false,
      );

      final updated = original.copyWith(
        allowBacktrack: false,
        perQuestionTimeLimit: Duration(seconds: 45),
        autoSubmitOnTimeout: true,
      );

      expect(updated.allowBacktrack, isFalse);
      expect(updated.allowChangeAnswer, isTrue); // unchanged
      expect(updated.correctnessVisibility, CorrectnessVisibility.afterSubmit);
      expect(updated.overallTimeLimit, const Duration(minutes: 10));
      expect(updated.perQuestionTimeLimit, const Duration(seconds: 45));
      expect(updated.autoSubmitOnTimeout, isTrue);
    });
  });
}
