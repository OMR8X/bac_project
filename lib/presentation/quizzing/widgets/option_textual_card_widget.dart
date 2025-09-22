import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:flutter/material.dart';

class OptionTextualFieldWidget extends StatefulWidget {
  const OptionTextualFieldWidget({
    super.key,
    required this.option,
    required this.questionAnswer,
    this.onSubmitText,
    this.testMode,
    required this.didAnswer,
  });
  //
  final Option option;
  final QuestionAnswer? questionAnswer;
  final TestMode? testMode;
  final bool didAnswer;
  final Function(String value)? onSubmitText;

  @override
  State<OptionTextualFieldWidget> createState() => _OptionTextualFieldWidgetState();
}

class _OptionTextualFieldWidgetState extends State<OptionTextualFieldWidget> {
  late TextEditingController controller;
  late bool didAnswer, reviewMode;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    didAnswer = widget.didAnswer && widget.questionAnswer?.answerText != null;
    reviewMode = widget.testMode == null;
    controller = TextEditingController(text: widget.questionAnswer?.answerText);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Color getCardColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = widget.questionAnswer != null;
    if (isSelected && reviewMode) {
      return widget.questionAnswer?.isCorrect == true
          ? optionCardColors.backgroundCorrect
          : optionCardColors.backgroundIncorrect;
    }
    return optionCardColors.background;
  }

  Color getCardBorderColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = widget.questionAnswer != null;
    final reviewMode = widget.testMode == null;
    if (isSelected && reviewMode) {
      return widget.questionAnswer?.isCorrect == true
          ? optionCardColors.bordersCorrect
          : optionCardColors.bordersIncorrect;
    }
    return optionCardColors.borders;
  }

  Color getCardTitleColor(BuildContext context) {
    final optionCardColors = Theme.of(context).extension<OptionCardColors>()!;
    final isSelected = widget.questionAnswer != null;
    final reviewMode = widget.testMode == null;
    if (isSelected && reviewMode) {
      final green = optionCardColors.textCorrect;
      final red = optionCardColors.textIncorrect;
      return widget.questionAnswer?.isCorrect == true ? green.darker(0.5) : red.darker(0.5);
    }
    return optionCardColors.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Margins.optionCardMargin,
      child: Column(
        children: [
          Card(
            margin: Margins.zero,
            color: getCardColor(context),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: getCardBorderColor(context)),
              borderRadius: BorderRadiusResource.optionCardBorderRadius,
            ),
            child: Padding(
              padding: Paddings.customPadding(0, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizesResources.fieldMediumHeight,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          // if (didAnswer && !reviewMode) ...[
                          //   SizedBoxes.s2h,
                          //   IconButton(
                          //     style: IconButton.styleFrom(
                          //       backgroundColor: Colors.transparent,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadiusResource.optionCardBorderRadius,
                          //       ),
                          //       side: BorderSide(color: Colors.transparent),
                          //     ),
                          //     onPressed: () {
                          //       if (widget.onSubmitText == null) return;
                          //       setState(() {
                          //         didAnswer = false;
                          //       });
                          //       WidgetsBinding.instance.addPostFrameCallback((_) {
                          //         focusNode.requestFocus();
                          //       });
                          //     },
                          //     icon: Image.asset(
                          //       UIImagesResources.penIcon,
                          //       color: Theme.of(context).colorScheme.primary,
                          //       width: 14,
                          //       height: 14,
                          //     ),
                          //   ),
                          // ] else if (!didAnswer && !reviewMode) ...[
                          //   SizedBoxes.s2h,
                          //   IconButton(
                          //     style: IconButton.styleFrom(
                          //       backgroundColor: Colors.transparent,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadiusResource.optionCardBorderRadius,
                          //       ),
                          //       side: BorderSide(color: Colors.transparent),
                          //     ),
                          //     onPressed: () {
                          //       if (widget.onSubmitText == null) return;
                          //       setState(() {
                          //         didAnswer = true;
                          //       });
                          //       widget.onSubmitText!(controller.text);
                          //     },
                          //     icon: Image.asset(
                          //       UIImagesResources.checkIcon,
                          //       color: Theme.of(context).colorScheme.primary,
                          //       width: 14,
                          //       height: 14,
                          //     ),
                          //   ),
                          // ],
                          if (widget.option.sortOrder != null) ...[
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusResource.optionCardBorderRadius,
                                ),
                                disabledBackgroundColor:
                                    Theme.of(context).colorScheme.primaryContainer,
                                side: BorderSide(color: Colors.transparent),
                              ),
                              onPressed: null,
                              icon: Text(
                                widget.option.sortOrder.toString(),
                                style: TextStylesResources.cardMediumSubtitle.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            SizedBoxes.s2h,
                          ],
                          Expanded(
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              enabled: (widget.onSubmitText != null),
                              onChanged: (value) {
                                if (widget.onSubmitText == null) return;
                                widget.onSubmitText!(value);
                              },

                              style: TextStylesResources.textField.copyWith(
                                fontSize: FontSizeResources.s12,
                                color: getCardTitleColor(context),
                              ),

                              decoration: InputDecoration(
                                hintText: context.l10n.hintsTextualOptionHint,
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadiusResource.optionCardBorderRadius,
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadiusResource.optionCardBorderRadius,
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadiusResource.optionCardBorderRadius,
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadiusResource.optionCardBorderRadius,
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (reviewMode) ...[
            Container(
              padding: Paddings.cardMediumPadding,
              // color: getCardColor(context),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  SizedBoxes.s2h,
                  Flexible(
                    child: Text(
                      widget.option.content,
                      style: TextStylesResources.cardMediumSubtitle.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxes.s4v,
          ],
        ],
      ),
    );
  }
}
