import 'dart:ui';

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
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: SpacesResources.s1),
          Text(
            'اختبر معلوماتك في جميع الدروس',
            style: AppFontStyles.makeFontStyle(
              fontWeight: FontWeightResources.medium,
              fontSize: FontSizeResources.s10,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: SpacesResources.s2),
          Row(
            children: [
              Icon(
                Icons.book_outlined,
                size: FontSizeResources.s10,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              const SizedBox(width: SpacesResources.s1),
              Text(
                '$lessonCount درس',
                style: AppFontStyles.makeFontStyle(
                  fontSize: FontSizeResources.s10,
                  fontWeight: FontWeightResources.medium,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
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
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: Icon(Icons.book, color: Theme.of(context).colorScheme.onSecondary, size: 24),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onTestAllLessonsPressed,
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
            side: BorderSide(color: Colors.transparent),
          ),
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 24,
          ),
        ),
        // SizedBox(
        //   width: 110,
        //   height: SizesResources.buttonSmallHeight,
        //   child: OutlinedButton.icon(
        //     style: OutlinedButton.styleFrom(
        //       backgroundColor: Theme.of(context).colorScheme.secondary,
        //       foregroundColor: Theme.of(context).colorScheme.onsecondary,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
        //       side: BorderSide(color: Colors.transparent),
        //     ),
        //     onPressed: onTestAllLessonsPressed,
        //     icon: Icon(Icons.arrow_forward, size: 24),
        //     iconAlignment: IconAlignment.end,
        //     label: Text(
        //       '',
        //       style: TextStylesResources.button.copyWith(
        //         color: Theme.of(context).colorScheme.onsecondary,
        //         fontSize: FontSizeResources.s10,
        //         fontWeight: FontWeightResources.bold,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.fullTestCardPadding,
      child: ClipRRect(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusResource.cardBorderRadius,
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withAlpha(100),
                width: SizesResources.cardMediumBorderWidth,
              ),
              color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(200),
            ),
            child: InkWell(
              borderRadius: BorderRadiusResource.cardBorderRadius,
              onTap: onTestAllLessonsPressed,
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
            ),
          ),
        ),
      ),
    );
  }
}
