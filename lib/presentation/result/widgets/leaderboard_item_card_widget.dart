import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';

class LeaderboardItemCardWidget extends StatelessWidget {
  const LeaderboardItemCardWidget({
    super.key,
    required this.result,
    required this.rank,
    required this.isCurrentUser,
    this.onTap,
  });

  final Result result;
  final int rank;
  final bool isCurrentUser;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final int percent = result.score.round().clamp(0, 100);
    final Color backgroundColor = _getScoreBackgroundColor(context, percent);
    final Color textColor = _getScoreTextColor(context, percent);

    return Card(
      color: isCurrentUser ? theme.colorScheme.surfaceContainerHigh : null,
      margin: Margins.zero,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: Paddings.cardMediumPadding,
          child: Row(
            children: [
              SizedBox(width: 36, child: Text('$rank', style: TextStylesResources.cardSmallTitle)),
              const SizedBox(width: SpacesResources.s4),
              Container(
                width: 44,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$percent%',
                    style: TextStylesResources.cardSmallTitle.copyWith(color: textColor),
                  ),
                ),
              ),
              const SizedBox(width: SpacesResources.s6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.lessonTitle ?? '',
                      style: TextStylesResources.cardMediumTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SpacesResources.s1),
                    Text(
                      result.createdAt.toLocal().toIso8601String().split('T').first,
                      style: TextStylesResources.cardSmallSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isCurrentUser) ...[
                const SizedBox(width: SpacesResources.s4),
                Chip(
                  label: Text(
                    'You',
                    style: TextStylesResources.statLabelStyle.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreBackgroundColor(BuildContext context, int score) {
    if (score > 50) {
      if (score >= 85) {
        return Theme.of(context).extension<ExtraColors>()!.green.withAlpha(20);
      } else {
        return Theme.of(context).extension<ExtraColors>()!.orange.withAlpha(20);
      }
    } else {
      return Theme.of(context).extension<ExtraColors>()!.red.withAlpha(20);
    }
  }

  Color _getScoreTextColor(BuildContext context, int score) {
    if (score > 50) {
      if (score >= 85) {
        return Theme.of(context).extension<ExtraColors>()!.green.withOpacity(0.9);
      } else {
        return Theme.of(context).extension<ExtraColors>()!.orange.withOpacity(0.9);
      }
    } else {
      return Theme.of(context).extension<ExtraColors>()!.red.withOpacity(0.9);
    }
  }
}
