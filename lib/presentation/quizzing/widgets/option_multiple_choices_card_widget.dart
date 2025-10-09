import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/test_mode.dart';

class OptionMultipleChoicesCardWidget extends StatelessWidget {
  const OptionMultipleChoicesCardWidget({
    super.key,
    required this.option,
    required this.questionAnswer,
    this.testMode,
    this.onSelectOption,
    required this.didAnswer,
  });
  //
  final Option option;
  final QuestionAnswer? questionAnswer;
  final TestMode? testMode;
  final bool didAnswer;
  final Function(Option option)? onSelectOption;
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
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: getCardBorderColor(context),
            width: SizesResources.cardMediumBorderWidth,
            // width:
            //     (questionAnswer != null)
            //         ? SizesResources.cardLargeBorderWidth
            // : SizesResources.cardMediumBorderWidth,
          ),
          borderRadius: BorderRadiusResource.optionCardBorderRadius,
        ),
        leading: Icon(
          questionAnswer != null ? Icons.radio_button_checked : Icons.radio_button_off,
          size: 20,
          color: getRadioIconColor(context),
        ),
        title: Text(
          option.content,
          style: TextStylesResources.optionsTitle.copyWith(color: getCardTitleColor(context)),
        ),
        onTap: didAnswer ? null : () => onSelectOption?.call(option),
      ),
    );
  }

  Color getRadioIconColor(BuildContext context) {
    final isSelected = questionAnswer != null;
    final reviewMode = testMode == null;
    if (reviewMode && option.isCorrect == true) {
      return Theme.of(context).extension<SuccessColors>()!.success;
    }
    if (isSelected) {
      if (reviewMode) {
        return questionAnswer?.isCorrect == true
            ? Theme.of(context).extension<SuccessColors>()!.success
            : Theme.of(context).colorScheme.error;
      } else {
        return Theme.of(context).colorScheme.primary;
      }
    }
    return Theme.of(context).colorScheme.outline;
  }

  Color getCardColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = questionAnswer != null;
    final reviewMode = testMode == null;
    if (reviewMode && option.isCorrect == true) {
      return optionCardColors.backgroundCorrect;
    }
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
    if (reviewMode && option.isCorrect == true) {
      return optionCardColors.bordersCorrect;
    }
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
    if (reviewMode && option.isCorrect == true) {
      return optionCardColors.textCorrect;
    }
    if (isSelected && reviewMode) {
      final green = optionCardColors.textCorrect;
      final red = optionCardColors.textIncorrect;
      return questionAnswer?.isCorrect == true ? green.darker(0.5) : red.darker(0.5);
    }
    return optionCardColors.text;
  }
}
