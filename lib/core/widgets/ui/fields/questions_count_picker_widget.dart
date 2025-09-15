import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';

import 'package:flutter/material.dart';

class QuestionCountPickerWidget extends StatelessWidget {
  const QuestionCountPickerWidget({
    super.key,
    required this.options,
    required this.initialCount,
    required this.onChanged,
  });

  final List<int> options;
  final int? initialCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.cardMargin,
      child: Padding(
        padding: Paddings.chipCardPadding,
        child: ListTile(
          title: Padding(
            padding: Paddings.cardMediumTitlePadding,
            child: Text(
              context.l10n.pickQuestionsCountTitle,
              style: TextStylesResources.cardMediumTitle,
            ),
          ),
          subtitle: Wrap(
            spacing: SpacesResources.s4,
            children:
                options.map((value) {
                  final isSelected = initialCount == value;
                  return ChoiceChip(
                    label: Text(value.toString()),
                    selected: isSelected,
                    onSelected: (_) {
                      onChanged(value);
                    },
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
