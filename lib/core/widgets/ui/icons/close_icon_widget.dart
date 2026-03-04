import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CloseIconWidget extends StatelessWidget {
  const CloseIconWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget.asset(
      asset: UIImagesResources.closeUIIcon,
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}
