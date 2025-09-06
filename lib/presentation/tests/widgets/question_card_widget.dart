import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// test_mode not used in this widget

class QuestionCardWidget extends StatelessWidget {
  const QuestionCardWidget({super.key, required this.question});
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.questionsCardMargin,
      shadowColor: Colors.transparent,
      color: getCardColor(context),
      shape: getShape(context),
      child: ListTile(
        contentPadding: PaddingResources.questionCardInnerPadding,
        shape: getShape(context),

        title: Column(
          spacing: SpacesResources.s4,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(question.text, textAlign: TextAlign.start, style: AppTextStyles.questionsTitle.copyWith(color: getCardTitleColor(context))),
            if (question.imageUrl != null)
              Card(
                shape: getShape(context),
                margin: PaddingResources.questionImageOuterPadding,
                child: Padding(
                  padding: PaddingResources.questionImageInnerPadding,
                  child: Image.network(
                    question.imageUrl!,
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                      if (frame != null) return child;
                      return Center(child: CupertinoActivityIndicator());
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ShapeBorder getShape(BuildContext context) {
    return RoundedRectangleBorder(side: BorderSide(color: getCardBorderColor(context)), borderRadius: BorderRadiusResource.optionCardBorderRadius);
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
