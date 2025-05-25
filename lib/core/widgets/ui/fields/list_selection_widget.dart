import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/decoration_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:flutter/material.dart';
import '../../../resources/styles/sizes_resources.dart';
import '../../dialogs/list_selection_dialog.dart';

class ListSelectionWidget<T> extends StatelessWidget {
  const ListSelectionWidget({super.key, required this.title, required this.context, required this.onSelect, required this.toText, required this.items, required this.selectedItems});
  final String title;
  final BuildContext context;
  final void Function(List<T>) onSelect;
  final String Function(T) toText;
  final List<T> items;
  final List<T> selectedItems;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: SizesResources.mainWidth(context),
          height: 50,
          child: Container(
            decoration: DecorationResources.inputFieldDecoration(theme: Theme.of(context)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadiusResource.tileBorderRadius,
              child: InkWell(
                onTap: () {
                  listSelectionDialog<T>(context: context, toText: toText, items: items, selectedItems: selectedItems, onSelect: onSelect);
                },
                borderRadius: BorderRadiusResource.tileBorderRadius,
                child: Center(child: Text(title, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeightResources.bold))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
