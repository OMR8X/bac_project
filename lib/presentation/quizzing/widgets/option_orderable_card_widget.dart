import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionOrderableCardWidget extends StatelessWidget {
  const OptionOrderableCardWidget({
    super.key,
    required this.option,
    required this.questionAnswer,
    this.testMode,
    required this.didAnswer,
    required this.index,
  });
  final Option option;
  final QuestionAnswer? questionAnswer;
  final TestMode? testMode;
  final bool didAnswer;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.optionCardMargin,
      color: getCardColor(context),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadiusResource.optionCardBorderRadius,
      ),
      child: ListTile(
        leading: ReorderableDragStartListener(
          index: index,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) {
              HapticFeedback.lightImpact();
            },
            child: Image.asset(
              UIImagesResources.dragHandlerIcon,
              width: 20,
              height: 20,
              color: getCardTitleColor(context),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getCardBorderColor(context)),
          borderRadius: BorderRadiusResource.optionCardBorderRadius,
        ),
        trailing: Text(
          option.sortOrder?.toString() ?? "",
          style: TextStylesResources.cardMediumSubtitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeightResources.medium,
          ),
        ),
        title: Text(
          option.content,
          style: TextStylesResources.optionsTitle.copyWith(color: getCardTitleColor(context)),
        ),
      ),
    );
  }

  Color getCardColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = questionAnswer != null;
    final reviewMode = testMode == null;
    if (isSelected && reviewMode) {
      return questionAnswer?.isCorrect == true
          ? optionCardColors.backgroundCorrect
          : optionCardColors.backgroundIncorrect;
    }
    return optionCardColors.background;
  }

  Color getCardBorderColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = questionAnswer != null;
    final reviewMode = testMode == null;
    if (isSelected && reviewMode) {
      return questionAnswer?.isCorrect == true
          ? optionCardColors.bordersCorrect
          : optionCardColors.bordersIncorrect;
    }
    return optionCardColors.borders;
  }

  Color getCardTitleColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = questionAnswer != null;
    final reviewMode = testMode == null;
    if (isSelected && reviewMode) {
      final green = optionCardColors.textCorrect;
      final red = optionCardColors.textIncorrect;
      return questionAnswer?.isCorrect == true ? green.darker(0.5) : red.darker(0.5);
    }
    return optionCardColors.text;
  }
}
