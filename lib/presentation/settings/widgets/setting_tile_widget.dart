import 'package:flutter/material.dart';

import '../../../core/resources/styles/font_styles_manager.dart';
import '../../../core/resources/styles/sizes_resources.dart';

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({
    super.key,
    required this.leadingIcon,
    this.trailingIcon,
    required this.title,
    this.data,
    required this.onTap,
  });

  final Widget leadingIcon;
  final IconData? trailingIcon;
  final String title;
  final String? data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      trailing: trailingIcon != null ? Icon(trailingIcon) : null,
      title: Text(title, style: TextStylesResources.cardMediumTitle),
      subtitle: data != null ? Text(data!) : null,
      onTap: onTap,
    );
  }
}
