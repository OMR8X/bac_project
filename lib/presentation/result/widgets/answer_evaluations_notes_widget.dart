import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/styles/font_styles_manager.dart';
import '../../../core/resources/styles/spacing_resources.dart';
import '../../../features/tests/domain/entities/answer_evaluation.dart';

class AnswerEvaluationsNotesWidget extends StatelessWidget {
  const AnswerEvaluationsNotesWidget({super.key, this.option, required this.answerEvaluation});
  final Option? option;
  final AnswerEvaluation? answerEvaluation;

  @override
  Widget build(BuildContext context) {
    if (answerEvaluation?.isCorrect == true) {
      return SizedBox.shrink();
    }

    final hasCorrectAnswer = option != null;
    final hasNotes = answerEvaluation?.notes?.isNotEmpty ?? false;

    if (!hasCorrectAnswer && !hasNotes) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Correct Answer Section - Primary Focus
        if (hasCorrectAnswer) ...[_buildCorrectAnswerSection(context)],
        // AI Notes Section - Secondary but Important
        if (hasNotes) ...[_buildAINotesSection(context)],
      ],
    );
  }

  Widget _buildCorrectAnswerSection(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: Margins.cardMargin,
        decoration: BoxDecoration(
          color: optionCardColors.backgroundCorrect,
          // borderRadius: BorderRadiusResource.bordersRadiusTiny,
          border: Border(
            right: BorderSide(color: optionCardColors.bordersCorrect, width: 4),
            // left: BorderSide(color: optionCardColors.bordersCorrect, width: 3),
          ),
        ),
        child: Padding(
          padding: Paddings.cardMediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   context.l10n.correctAnswerLabel,
              //   style: TextStylesResources.caption.copyWith(color: optionCardColors.textCorrect),
              // ),
              // SizedBoxes.s2v,
              Text(
                '"${option!.content}"',
                style: TextStylesResources.cardSmallTitle.copyWith(color: optionCardColors.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAINotesSection(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: Margins.cardMargin,
        decoration: BoxDecoration(
          color: optionCardColors.backgroundNotes,
          // borderRadius: BorderRadiusResource.bordersRadiusTiny,
          border: Border(
            right: BorderSide(color: optionCardColors.bordersNotes, width: 4),
            // left: BorderSide(color: optionCardColors.bordersNotes, width: 3),
          ),
        ),
        child: Padding(
          padding: Paddings.cardMediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   context.l10n.aiFeedbackLabel,
              //   style: TextStylesResources.caption.copyWith(color: optionCardColors.textNotes),
              // ),
              // SizedBoxes.s2v,
              Text(
                answerEvaluation!.notes!,
                style: TextStylesResources.cardSmallTitle.copyWith(color: optionCardColors.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
