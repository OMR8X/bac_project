import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:flutter/material.dart';

class AppBarIconWidget extends StatelessWidget {
  const AppBarIconWidget({super.key, required this.icon, required this.onPressed, this.padding});
  final Widget icon;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.only(right: Paddings.screenSidesPadding.right),
        child: SizedBox(
          width: SizesResources.iconButtonAppBarHeight,
          height: SizesResources.iconButtonAppBarHeight,
          child: FittedBox(
            child: IconButton(
              style: IconButton.styleFrom(
                minimumSize: Size(
                  SizesResources.iconButtonAppBarHeight,
                  SizesResources.iconButtonAppBarHeight,
                ),
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                backgroundColor: Theme.of(context).colorScheme.surface,
                padding: Paddings.zero,
              ),
              padding: Paddings.zero,
              onPressed: onPressed,
              icon: SizedBox(
                width: SizesResources.iconAppBarHeight,
                height: SizesResources.iconAppBarHeight,
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
