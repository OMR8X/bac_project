import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/spaces_resources.dart';

class LessonCardWidget extends StatelessWidget {
  final String title;
  final int? questionsCount;
  final VoidCallback onTap;
  final IconData icon;
  final bool? isSelected;

  const LessonCardWidget({
    super.key,
    required this.title,
    this.questionsCount,
    required this.onTap,
    required this.icon,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Margins.cardMargin / 2,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: Paddings.cardLessonPadding,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildIconBox(context),
                const SizedBox(width: 12),
                Expanded(child: _buildTextInformation(context)),
                const SizedBox(width: 12),
                if (isSelected == null)
                  Padding(
                    padding: const EdgeInsets.all(SpacesResources.s4),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: SpacesResources.s6,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(SpacesResources.s4),
                    child: SizedBox(
                      width: SpacesResources.s10,
                      height: SpacesResources.s10,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (bool? value) {
                          onTap();
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacesResources.s5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 20),
    );
  }

  Widget _buildTextInformation(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStylesResources.cardMediumTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: SpacesResources.s3),
        if (questionsCount != null)
          Row(
            children: [
              Icon(
                Icons.quiz_outlined,
                size: FontSizeResources.s12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: SpacesResources.s2),
              Text(
                "$questionsCount سوال",
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
}
