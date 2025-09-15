import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/spacing_resources.dart';
import '../../../resources/styles/sizes_resources.dart';
import '../../../resources/themes/extensions/surface_container_colors.dart';
import '../../animations/staggered_item_wrapper_widget.dart';

class DropDownWidget<T> extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.initialSelection,
    required this.entries,
    required this.toLabel,
    required this.onSelected,
    this.hintText,
    this.position = 1,
  });
  final int position;
  final String? hintText;
  final T? initialSelection;
  final List<T?> entries;
  final String Function(T? value) toLabel;
  final void Function(T? entry)? onSelected;

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_isDropdownOpen) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDropdownOpen,
      onPopInvokedWithResult: (didPop, result) {
        _onWillPop();
      },
      child: StaggeredItemWrapperWidget(
        position: widget.position,
        child: GestureDetector(
          onPanDown: (d) {
            setState(() => _isDropdownOpen = true);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: DropdownMenu(
            width: double.infinity,
            textStyle: TextStylesResources.title,
            hintText: widget.hintText,
            label: widget.hintText != null ? Text(widget.hintText!) : null,
            initialSelection: widget.initialSelection,
            onSelected: (item) {
              setState(() => _isDropdownOpen = false);
              FocusManager.instance.primaryFocus?.unfocus();
              if (widget.onSelected != null) {
                widget.onSelected!(item);
              }
            },
            dropdownMenuEntries:
                widget.entries.map((e) {
                  return DropdownMenuEntry<T?>(value: e, label: widget.toLabel(e));
                }).toList(),
          ),
        ),
      ),
    );
  }
}
