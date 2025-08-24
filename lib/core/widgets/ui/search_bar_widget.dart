import 'dart:async';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.onTap,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.heroTag,
  });

  final bool enabled;
  final String? heroTag;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final Duration debounceDuration;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isFieldEmpty = true;
  Timer? _debounce;
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
    _debounce?.cancel();
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

  void _onChangedDebounced(String value) {
    //
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    //
    if (value.isEmpty) {
      widget.onChanged?.call(value);
      return;
    }
    //
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: widget.heroTag ?? 'search_bar',
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: PaddingResources.searchBarPadding,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: widget.onTap,
              child: TextField(
                enabled: widget.enabled,
                controller: _searchController,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: context.l10n.searchHint,
                  suffixIcon:
                      isFieldEmpty
                          ? Icon(Icons.search, size: 24)
                          : IconButton(
                            onPressed: () {
                              _searchController.clear();
                            },
                            icon: Icon(Icons.clear, size: 24),
                          ),
                ),
                onChanged: _onChangedDebounced,
                onSubmitted: widget.onFieldSubmitted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
