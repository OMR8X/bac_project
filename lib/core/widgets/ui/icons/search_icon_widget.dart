import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget(
      icon: Image.asset(
        UIImagesResources.searchIcon,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed ?? () {},
    );
  }
}
