import 'package:bac_project/presentation/quizzing/widgets/option_textual_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../../features/tests/domain/entities/question.dart';
import '../../../features/tests/domain/entities/question_answer.dart';
import '../../../features/tests/domain/entities/test_mode.dart';

class TextualQuestionsBuilderWidget extends StatelessWidget {
  const TextualQuestionsBuilderWidget({
    super.key,
    required this.questionsAnswers,
    required this.question,
    this.onSubmitText,
    this.testMode,
  });
  final Question question;
  final List<QuestionAnswer> questionsAnswers;
  final Function(Option option, String value)? onSubmitText;
  final TestMode? testMode;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final option = question.options[index];
        return OptionTextualFieldWidget(
          key: ValueKey(question.options[index].id),
          questionAnswer: questionsAnswers.firstWhereOrNull(
            (answer) => answer.optionId == question.options[index].id,
          ),
          option: question.options[index],
          testMode: testMode,
          didAnswer: questionsAnswers.isNotEmpty,
          onSubmitText: onSubmitText == null ? null : (v) => onSubmitText?.call(option, v),
        );
      },
      itemCount: question.options.length,
    );
  }
}
