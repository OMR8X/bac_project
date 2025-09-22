import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/presentation/quizzing/widgets/option_multiple_choices_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../../features/tests/domain/entities/question.dart';
import '../../../features/tests/domain/entities/question_answer.dart';
import '../../../features/tests/domain/entities/test_mode.dart';
import '../../tests/widgets/question_card_widget.dart';

class MultipleChoicesQuestionBuilderWidget extends StatelessWidget {
  const MultipleChoicesQuestionBuilderWidget({
    super.key,
    required this.questionsAnswers,
    required this.question,
    this.testMode,
    this.onSelectOption,
  });
  final TestMode? testMode;
  final Question question;
  final List<QuestionAnswer> questionsAnswers;
  final Function(Option option)? onSelectOption;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return OptionMultipleChoicesCardWidget(
          key: ValueKey(question.options[index].id),
          questionAnswer: questionsAnswers.firstWhereOrNull(
            (answer) => answer.optionId == question.options[index].id,
          ),
          option: question.options[index],
          testMode: testMode,
          didAnswer: questionsAnswers.isNotEmpty,
          onSelectOption: onSelectOption,
        );
      },
      itemCount: question.options.length,
    );
  }
}
