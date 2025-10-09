import 'package:bac_project/features/results/domain/entities/answer_evaluation.dart';
import 'package:bac_project/presentation/quizzing/widgets/option_multiple_choices_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../../features/tests/domain/entities/question.dart';
import '../../../features/tests/domain/entities/question_answer.dart';
import '../../../features/tests/domain/entities/test_mode.dart';
import '../../result/widgets/answer_evaluations_card_widget.dart';

class MultipleChoicesQuestionBuilderWidget extends StatelessWidget {
  const MultipleChoicesQuestionBuilderWidget({
    super.key,
    required this.questionsAnswers,
    required this.question,
    this.testMode,
    this.onSelectOption,
    this.answerEvaluations,
  });
  final TestMode? testMode;
  final Question question;
  final List<QuestionAnswer> questionsAnswers;
  final Function(Option option)? onSelectOption;
  final List<AnswerEvaluation>? answerEvaluations;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final option = question.options[index];
        final questionAnswer = questionsAnswers.firstWhereOrNull(
          (answer) => answer.optionId == option.id,
        );
        final evaluation = answerEvaluations?.firstWhereOrNull(
          (evaluation) => evaluation.questionAnswerId == questionAnswer?.id,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OptionMultipleChoicesCardWidget(
              key: ValueKey(option.id),
              questionAnswer: questionAnswer,
              option: option,
              testMode: testMode,
              didAnswer: questionsAnswers.isNotEmpty,
              onSelectOption: onSelectOption,
            ),
            AnswerEvaluationsCardWidget(answerEvaluation: evaluation),
          ],
        );
      },
      itemCount: question.options.length,
    );
  }
}
