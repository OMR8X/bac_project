import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/test_mode.dart';

class OptionCardWidget extends StatelessWidget {
  const OptionCardWidget({
    super.key,
    required this.option,
    required this.isSelected,
    required this.testMode,
    required this.didAnswer,
    required this.onTap,
  });
  final Option option;
  final bool isSelected, didAnswer;
  final TestMode testMode;
  final Function(Option option) onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.optionCardMargin,
      color: getCardColor(context),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadiusResource.optionCardBorderRadius,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: getCardBorderColor(context),
            width: (didAnswer & isSelected) ? 1 : 0.5,
          ),
          borderRadius: BorderRadiusResource.optionCardBorderRadius,
        ),
        leading: Icon(
          isSelected
              ? Icons.radio_button_checked
              : Icons.radio_button_off,
          size: 20,
          color: getRadioIconColor(context),
        ),
        title: Text(
          option.text,
          style: AppTextStyles.optionsTitle.copyWith(
            color: getCardTitleColor(context),
          ),
        ),
        onTap: didAnswer ? null : () => onTap(option),
      ),
    );
  }

  Color getRadioIconColor(BuildContext context) {
    if (isSelected) {
      if (testMode == TestMode.exploring &&
          option.isCorrect != null) {
        final green =
            Theme.of(context).extension<SuccessColors>()!.success;
        final red = Theme.of(context).colorScheme.error;
        return option.isCorrect! ? green : red;
      }
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.outline;
  }

  Color getCardColor(BuildContext context) {
    if (isSelected) {
      if (testMode == TestMode.exploring &&
          option.isCorrect != null) {
        final green =
            Theme.of(context).extension<SuccessColors>()!.onSuccess;
        final red = Theme.of(context).colorScheme.errorContainer;
        return option.isCorrect!
            ? green.lighter(0.75)
            : red.lighter(0.75);
      }
    } else if (didAnswer &&
        option.isCorrect == true &&
        testMode == TestMode.exploring) {
      final green =
          Theme.of(context).extension<SuccessColors>()!.onSuccess;
      return green.lighter(0.75);
    }
    return Theme.of(context).colorScheme.surfaceContainer;
  }

  Color getCardBorderColor(BuildContext context) {
    if (isSelected) {
      if (testMode == TestMode.exploring &&
          option.isCorrect != null) {
        final green =
            Theme.of(context).extension<SuccessColors>()!.success;
        final red = Theme.of(context).colorScheme.error;
        return option.isCorrect! ? green : red;
      }
      return Theme.of(context).colorScheme.primary;
    } else if (didAnswer &&
        option.isCorrect == true &&
        testMode == TestMode.exploring) {
      final green =
          Theme.of(context).extension<SuccessColors>()!.success;
      return green;
    }
    return Theme.of(context).colorScheme.outline;
  }

  Color getCardTitleColor(BuildContext context) {
    if (isSelected) {
      if (testMode == TestMode.exploring &&
          option.isCorrect != null) {
        final green =
            Theme.of(context).extension<SuccessColors>()!.success;
        final red = Theme.of(context).colorScheme.error;
        return option.isCorrect!
            ? green.darker(0.5)
            : red.darker(0.5);
      }
      return Theme.of(context).colorScheme.onSurface;
    }
    return Theme.of(context).colorScheme.onSurface;
  }
}
