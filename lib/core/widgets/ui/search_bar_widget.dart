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
  static const Color _iconColor = Colors.grey;
  static const TextDirection _textDirection = TextDirection.rtl;
  static const TextAlign _textAlign = TextAlign.right;
  static const IconData _searchIcon = Icons.search;

  // State variables
  bool isFieldEmpty = true;
  late final TextEditingController _searchController;

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
    return Card(
      child: Directionality(
        textDirection: _textDirection,
        child: TextField(
          controller: _searchController,
          textAlign: _textAlign,
          decoration: InputDecoration(
            hintText: sl<LocalizationManager>().get(LocalizationKeys.search.hint),
            suffixIcon: Icon(_searchIcon, color: _iconColor, size: 24),
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onFieldSubmitted,
        ),
      ),
    );
  }
}
