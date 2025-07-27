import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:flutter/material.dart';

class QuestionCountPickerWidget extends StatelessWidget {
  const QuestionCountPickerWidget({
    super.key,
    required this.options,
    required this.initialCount,
    required this.onChanged,
  });

  final List<int> options;
  final int initialCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingResources.chipCardInnerPadding,
        child: ListTile(
          title: Padding(
            padding: PaddingResources.cardMediumTitlePadding,
            child: Text(
              sl<LocalizationManager>().get(
                LocalizationKeys.testProperties.questionsCount.questionsCount,
              ),
              style: AppTextStyles.cardMediumTitle,
            ),
          ),
          subtitle: Wrap(
            spacing: SpacesResources.s4,
            children:
                options.map((value) {
                  final isSelected = initialCount == value;
                  return ChoiceChip(
                    label: Text(value == 35 ? "30+" : value.toString()),
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
