import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/spaces_resources.dart';

class LessonCardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final IconData icon;

  const LessonCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.cardOuterPadding,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: PaddingResources.cardLargeInnerPadding,
          child: Row(
            children: [
              _buildIconBox(context),
              const SizedBox(width: 12),
              Expanded(child: _buildTextInformation(context)),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
    );
  }

  Widget _buildTextInformation(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.cardMediumTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        if (subtitle != null)
          Text(
            subtitle!,
            style: AppTextStyles.cardMediumSubtitle.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
