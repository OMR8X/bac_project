import 'dart:math';

import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class UnitCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int? lessonsCount;
  final VoidCallback onStartTestPressed;
  final VoidCallback onExploreLessonsPressed;
  final IconData icon;

  const UnitCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.lessonsCount,
    required this.onStartTestPressed,
    required this.onExploreLessonsPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title, $subtitle',
      explicitChildNodes: true,
      child: Card(
        margin: Margins.cardMargin,
        child: InkWell(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          onTap: onExploreLessonsPressed,
          child: Padding(
            padding: Paddings.cardLargePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInformationSection(context),
                // const SizedBox(height: SpacesResources.s8),
                // _buildButtonsSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformationSection(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildIconBox(context),
          const SizedBox(width: SpacesResources.s6),
          Expanded(child: _buildTextInformation(context)),
        ],
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacesResources.s6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 28),
    );
  }

  Widget _buildTextInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Category/Type text - smaller and subtle
        Text(
          title,
          style: TextStylesResources.caption.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
            fontSize: FontSizeResources.s10,
            fontWeight: FontWeightResources.medium,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: SpacesResources.s3),

        // Main title - prominent and readable
        Text(
          subtitle,
          style: TextStylesResources.cardMediumTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: FontSizeResources.s16,
            fontWeight: FontWeightResources.bold,
            height: 1.2,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: SpacesResources.s3),

        // Lessons count - subtle but informative
        if (lessonsCount != null)
          Row(
            children: [
              Icon(
                Icons.book_outlined,
                size: FontSizeResources.s12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: SpacesResources.s1),
              Text(
                "$lessonsCount دروس",
                style: TextStylesResources.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: FontSizeResources.s10,
                  fontWeight: FontWeightResources.medium,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
              padding: const EdgeInsets.symmetric(
                horizontal: SpacesResources.s6,
                vertical: SpacesResources.s4,
              ),
              textStyle: TextStylesResources.button.copyWith(
                fontSize: FontSizeResources.s12,
                fontWeight: FontWeightResources.medium,
              ),
            ),
            onPressed: onExploreLessonsPressed,
            iconAlignment: IconAlignment.end,
            icon: Icon(Icons.explore_outlined, size: FontSizeResources.s16),
            label: Text(context.l10n.homeCardExploreLessonsAction),
          ),
        ),
        const SizedBox(width: SpacesResources.s5),
        Expanded(
          flex: 2,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
              padding: const EdgeInsets.symmetric(
                horizontal: SpacesResources.s6,
                vertical: SpacesResources.s4,
              ),
              textStyle: TextStylesResources.button.copyWith(
                fontSize: FontSizeResources.s12,
                fontWeight: FontWeightResources.bold,
              ),
            ),
            onPressed: onStartTestPressed,
            iconAlignment: IconAlignment.end,
            icon: Transform.rotate(
              angle: pi,
              child: Icon(Icons.play_arrow_rounded, size: FontSizeResources.s16),
            ),
            label: Text(context.l10n.homeCardStartTestAction),
          ),
        ),
      ],
    );
  }
}
