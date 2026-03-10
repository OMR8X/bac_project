import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:neuro_app/core/resources/styles/sizes_resources.dart';
import 'package:flutter/material.dart';

class AppBarIconWidget extends StatelessWidget {
  const AppBarIconWidget._({
    super.key,
    this.iconData,
    this.iconAsset,
    required this.onPressed,
    this.padding,
  });

  /// Use this for Flutter's built-in IconData (e.g., Icons.home)
  const AppBarIconWidget.icon({
    Key? key,
    required IconData icon,
    required VoidCallback onPressed,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         iconData: icon,
         onPressed: onPressed,
         padding: padding,
       );

  /// Use this for custom image assets (e.g., 'assets/icons/bell.png')
  const AppBarIconWidget.asset({
    Key? key,
    required String asset,
    required VoidCallback onPressed,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         iconAsset: asset,
         onPressed: onPressed,
         padding: padding,
       );

  final IconData? iconData;
  final String? iconAsset;
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
              style: Theme.of(context).iconButtonTheme.style?.copyWith(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.surface,
                ),
              ),
              padding: Paddings.zero,
              onPressed: onPressed,
              icon: SizedBox(
                width: SizesResources.iconAppBarHeight,
                height: SizesResources.iconAppBarHeight,
                child: _buildIcon(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconData != null) {
      return Icon(iconData);
    } else if (iconAsset != null) {
      return ImageIcon(AssetImage(iconAsset!));
    }
    throw ArgumentError('Either iconData or iconAsset must be provided');
  }
}
