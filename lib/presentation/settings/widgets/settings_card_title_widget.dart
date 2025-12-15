import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/font_styles_manager.dart';

class SettingsCardTitleWidget extends StatelessWidget {
  const SettingsCardTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: SizesResources.sidePadding / 2,
        vertical: SpacesResources.s1,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStylesResources.cardSmallTitle.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
