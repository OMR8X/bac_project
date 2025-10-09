import 'package:bac_project/features/results/domain/entities/answer_evaluation.dart';
import 'package:bac_project/presentation/quizzing/widgets/option_orderable_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/option.dart';
import '../../../features/tests/domain/entities/question.dart';
import '../../../features/tests/domain/entities/question_answer.dart';
import '../../../features/tests/domain/entities/test_mode.dart';
import '../../result/widgets/answer_evaluations_card_widget.dart';

class OrderableQuestionBuilderWidget extends StatelessWidget {
  const OrderableQuestionBuilderWidget({
    super.key,
    required this.questionsAnswers,
    required this.question,
    this.testMode,
    this.onSubmitOrder,
    this.answerEvaluations,
  });
  final TestMode? testMode;
  final Question question;
  final List<QuestionAnswer> questionsAnswers;
  final List<AnswerEvaluation>? answerEvaluations;
  final Function(List<QuestionAnswer> answers)? onSubmitOrder;

  List<Option> _buildOrderedOptions() {
    if (questionsAnswers.isNotEmpty) {
      final orderedOptions = List<Option>.from(question.options);
      orderedOptions.sort((a, b) {
        final answerA = questionsAnswers.firstWhereOrNull((answer) => answer.optionId == a.id);
        final answerB = questionsAnswers.firstWhereOrNull((answer) => answer.optionId == b.id);
        final positionA = answerA?.answerPosition ?? 0;
        final positionB = answerB?.answerPosition ?? 0;
        return positionA.compareTo(positionB);
      });
      return orderedOptions;
    } else {
      return List<Option>.from(question.options);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderedOptions = _buildOrderedOptions();
    return ReorderableListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orderedOptions.length,
      onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex, orderedOptions),
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Material(
              type: MaterialType.transparency,
              elevation: 10,
              // shadowColor: Colors.transparent,
              child: child,
            );
          },
        );
      },
      itemBuilder: (context, index) {
        final option = orderedOptions[index];
        final questionAnswer = questionsAnswers.firstWhereOrNull(
          (answer) => answer.optionId == option.id,
        );
        final evaluation = answerEvaluations?.firstWhereOrNull(
          (evaluation) => evaluation.questionAnswerId == questionAnswer?.id,
        );
        return Column(
          key: ValueKey(option.id),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OptionOrderableCardWidget(
              questionAnswer: questionAnswer,
              option: option.copyWith(sortOrder: index + 1),
              testMode: testMode,
              didAnswer: false,
              index: index,
            ),
            AnswerEvaluationsCardWidget(
              answerEvaluation: evaluation,
            ),
          ],
        );
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex, List<Option> orderedOptions) {
    if (onSubmitOrder == null) return;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    /// Create a new list with the reordered items
    final reorderedOptions = List<Option>.from(orderedOptions);
    final item = reorderedOptions.removeAt(oldIndex);
    reorderedOptions.insert(newIndex, item);

    /// Auto-submit the new order after every change
    onSubmitOrder!(
      List<QuestionAnswer>.from(
        List.generate(
          reorderedOptions.length,
          (index) => QuestionAnswer(
            questionId: question.id,
            answerPosition: index,
            optionId: reorderedOptions[index].id,
          ),
        ),
      ),
    );
  }
}
