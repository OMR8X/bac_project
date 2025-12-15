import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.onTap,
    this.iconColor,
  });

  final String title;
  final String subtitle;
  final String iconPath;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: subtitle,
      waitDuration: const Duration(milliseconds: 500),
      child: Card(
        margin: Margins.statChipMargin,

        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.bordersRadiusMedium,
          side: BorderSide(color: theme.colorScheme.outline, width: 0.25),
        ),
        child: InkWell(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: Paddings.statChipPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side - Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStylesResources.statTitleStyle.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontSize: FontSizeResources.s16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const SizedBox(height: SpacesResources.s1),
                      // Text(
                      //   subtitle,
                      //   style: TextStylesResources.statLabelStyle.copyWith(
                      //     color: theme.colorScheme.onSurfaceVariant.lighter(0.4),
                      //     fontSize: FontSizeResources.s9,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Right side - Icon
                Image.asset(
                  iconPath,
                  width: 16,
                  height: 16,
                  color: iconColor ?? theme.colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
