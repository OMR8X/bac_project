import 'package:neuro_app/core/resources/styles/assets_resources.dart';
import 'package:neuro_app/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RetryIconWidget extends StatelessWidget {
  const RetryIconWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget.asset(
      asset: UIImagesResources.retryUIIcon,
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}
