import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/features/results/domain/entities/answer_evaluation.dart';
import 'package:bac_project/presentation/quizzing/widgets/option_textual_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../../features/tests/domain/entities/question.dart';
import '../../../features/tests/domain/entities/question_answer.dart';
import '../../../features/tests/domain/entities/test_mode.dart';
import '../../result/widgets/answer_evaluations_card_widget.dart';

class TextualQuestionsBuilderWidget extends StatelessWidget {
  const TextualQuestionsBuilderWidget({
    super.key,
    required this.questionsAnswers,
    required this.question,
    this.onSubmitText,
    this.testMode,
    this.answerEvaluations,
  });
  final Question question;
  final List<QuestionAnswer> questionsAnswers;
  final Function(Option option, String value)? onSubmitText;
  final TestMode? testMode;
  final List<AnswerEvaluation>? answerEvaluations;
  @override
  Widget build(BuildContext context) {
    question.options.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
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
            OptionTextualFieldWidget(
              key: ValueKey(option.id),
              questionAnswer: questionAnswer,
              option: option,
              testMode: testMode,
              didAnswer: questionsAnswers.isNotEmpty,
              onSubmitText: onSubmitText == null ? null : (v) => onSubmitText?.call(option, v),
            ),
            if (questionAnswer?.isCorrect != true && testMode == null)
              AnswerEvaluationsCardWidget(option: option, answerEvaluation: evaluation),
          ],
        );
      },
      itemCount: question.options.length,
    );
  }
}
