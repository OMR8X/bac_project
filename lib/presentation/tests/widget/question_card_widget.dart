import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:flutter/material.dart';

import '../../../features/tests/domain/entities/test_mode.dart';

class QuestionCardWidget extends StatelessWidget {
  const QuestionCardWidget({super.key, required this.question});
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.questionsCardMargin,
      shadowColor: Colors.transparent,
      color: getCardColor(context),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: getCardBorderColor(context), width: 1),
        borderRadius: BorderRadiusResource.optionCardBorderRadius,
      ),
      child: ListTile(
        contentPadding: PaddingResources.questionCardInnerPadding,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getCardBorderColor(context), width: 1),
          borderRadius: BorderRadiusResource.optionCardBorderRadius,
        ),

        title: Text(
          question.text,
          textAlign: TextAlign.start,
          style: AppTextStyles.questionsTitle.copyWith(color: getCardTitleColor(context)),
        ),
      ),
    );
  }

  Color getRadioIconColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline;
  }

  Color getCardColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainer;
  }

  Color getCardBorderColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline;
  }

  Color getCardTitleColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }
}
