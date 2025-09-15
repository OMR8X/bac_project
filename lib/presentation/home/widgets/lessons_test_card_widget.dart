import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class LessonsTestCardWidget extends StatelessWidget {
  final VoidCallback onTestAllLessonsPressed;
  final int lessonCount;

  const LessonsTestCardWidget({
    super.key,
    required this.onTestAllLessonsPressed,
    required this.lessonCount,
  });

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختبار شامل',
            style: AppFontStyles.makeFontStyle(
              fontSize: FontSizeResources.s16,
              fontWeight: FontWeightResources.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: SpacesResources.s1),
          Text(
            'اختبر معلوماتك في جميع الدروس',
            style: AppFontStyles.makeFontStyle(
              fontWeight: FontWeightResources.medium,
              fontSize: FontSizeResources.s10,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: SpacesResources.s2),
          Row(
            children: [
              Icon(
                Icons.book_outlined,
                size: FontSizeResources.s10,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              ),
              const SizedBox(width: SpacesResources.s1),
              Text(
                '$lessonCount درس',
                style: AppFontStyles.makeFontStyle(
                  fontSize: FontSizeResources.s10,
                  fontWeight: FontWeightResources.medium,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Center(
        child: Icon(Icons.book, color: Theme.of(context).colorScheme.primary, size: 24),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 110,
          height: SizesResources.buttonSmallHeight,
          child: FilledButton.icon(
            onPressed: onTestAllLessonsPressed,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
              elevation: 2,
              shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
              padding: const EdgeInsets.symmetric(
                horizontal: SpacesResources.s3,
                vertical: SpacesResources.s2,
              ),
              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              animationDuration: const Duration(milliseconds: 200),
            ),

            label: Text(
              'اختبر الآن',
              style: TextStylesResources.button.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: FontSizeResources.s11,
                fontWeight: FontWeightResources.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      color: Theme.of(context).colorScheme.primary,
      margin: Paddings.fullTestCardPadding,
      child: Padding(
        padding: Paddings.cardLargePadding,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildIcon(context),
                  const SizedBox(width: SpacesResources.s4),
                  _buildContent(context),
                  _buildActionButton(context),
                  const SizedBox(width: SpacesResources.s2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
