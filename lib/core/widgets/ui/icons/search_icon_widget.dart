import 'package:neuro_app/core/resources/styles/assets_resources.dart';
import 'package:neuro_app/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget.asset(
      asset: UIImagesResources.searchUIIcon,
      onPressed: onPressed ?? () {},
    );
  }
}
