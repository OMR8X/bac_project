import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, this.onChanged, this.onFieldSubmitted});

  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  // Style constants
  static const double _borderRadius = 8.0;
  static const Color _backgroundColor = Colors.black;
  static const Color _textColor = Colors.white;
  static const Color _fillColor = Color(0XFFEFEFF0);
  static const Color _hintTextColor = Colors.grey;
  static const Color _iconColor = Colors.grey;
  static const TextDirection _textDirection = TextDirection.rtl;
  static const TextAlign _textAlign = TextAlign.right;
  static const EdgeInsetsGeometry _contentPadding = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 16.0,
  );
  static const IconData _searchIcon = Icons.search;

  // State variables
  bool isFieldEmpty = true;
  late final TextEditingController _searchController;

  // Border styles
  late final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(_borderRadius),
    borderSide: BorderSide.none,
  );

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_updateFieldEmptyState);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateFieldEmptyState() {
    final isEmpty = _searchController.text.isEmpty;
    if (isFieldEmpty != isEmpty) {
      setState(() {
        isFieldEmpty = isEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Directionality(
        textDirection: _textDirection,
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: _textColor),
          textAlign: _textAlign,

          decoration: InputDecoration(
            fillColor: _fillColor,
            contentPadding: _contentPadding,
            hintText: sl<LocalizationManager>().get(
              LocalizationKeys.search.hint,
            ),
            hintStyle: TextStyle(color: _hintTextColor, fontSize: 13),
            suffixIcon: Icon(_searchIcon, color: _iconColor, size: 24),

            border: _inputBorder,
            enabledBorder: _inputBorder,
            focusedBorder: _inputBorder,
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onFieldSubmitted,
        ),
      ),
    );
  }
}
