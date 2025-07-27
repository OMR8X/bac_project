import 'dart:math';

import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:flutter/material.dart';

class UnitCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onStartTestPressed;
  final VoidCallback onExploreLessonsPressed;
  final IconData icon;

  const UnitCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onStartTestPressed,
    required this.onExploreLessonsPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: PaddingResources.cardOuterPadding,
      child: Padding(
        padding: PaddingResources.cardLargeInnerPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInformationSection(context),
            const SizedBox(height: 12),
            _buildButtonsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconBox(context),
        const SizedBox(width: 12),
        Expanded(child: _buildTextInformation(context)),
      ],
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
    );
  }

  Widget _buildTextInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.cardLargeTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTextStyles.cardMediumSubtitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onExploreLessonsPressed,
            icon: Icon(Icons.explore),
            label: Text(
              sl<LocalizationManager>().get(LocalizationKeys.home.card.exploreLessonsAction),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onStartTestPressed,
            icon: Transform.rotate(angle: pi, child: Icon(Icons.play_arrow)),
            label: Text(sl<LocalizationManager>().get(LocalizationKeys.home.card.startTestAction)),
          ),
        ),
      ],
    );
  }
}
