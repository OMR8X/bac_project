import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';

import 'package:flutter/material.dart';

class QuestionCategoriesPickerWidget<T> extends StatelessWidget {
  const QuestionCategoriesPickerWidget({
    super.key,
    required this.categories,
    required this.selected,
    required this.onChanged,
    required this.label,
  });

  final List<T> categories;
  final List<T> selected;
  final String Function(T) label;
  final ValueChanged<List<T>>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.cardMargin,
      child: ListTile(
        title: Padding(
          padding: Paddings.cardMediumTitlePadding,
          child: Text(
            context.l10n.pickQuestionsCategoriesTitle,
            style: TextStylesResources.cardMediumTitle,
          ),
        ),
        subtitle: Wrap(
          spacing: SpacesResources.s4,
          children:
              categories.map((value) {
                final isSelected = selected.contains(value);
                return ChoiceChip(
                  label: Text(label(value)),
                  selected: isSelected,
                  onSelected: (bool isSelected) {
                    final List<T> newSelected = List.from(selected);
                    if (isSelected) {
                      newSelected.add(value);
                    } else {
                      newSelected.remove(value);
                    }
                    onChanged?.call(newSelected);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
