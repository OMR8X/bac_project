import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';

class ResultCardWidget extends StatelessWidget {
  final Result result;

  const ResultCardWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final int percent = result.score.round();
    final Color scoreColor = Theme.of(context).colorScheme.onSurfaceVariant;
    return Card(
      margin: PaddingResources.cardOuterPadding,
      child: InkWell(
        borderRadius: BorderRadiusResource.cardBorderRadius,
        onTap: () {},
        child: Padding(
          padding: PaddingResources.cardMediumInnerPadding,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildIconBox(context),
                const SizedBox(width: SpacesResources.s6),
                Expanded(child: _buildMainInfo(context, percent, scoreColor)),
                const SizedBox(width: SpacesResources.s6),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox(BuildContext context) {
    final int percent = result.score.round();
    final Color backgroundColor = _getScoreBackgroundColor(context, percent);
    final Color textColor = _getScoreTextColor(context, percent);

    return Container(
      width: 50,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      ),
      child: Center(
        child: Text(
          '${percent.clamp(0, 100)}%'.replaceAll('.0', ''),
          style: AppTextStyles.cardSmallTitle.copyWith(
            fontSize: FontSizeResources.s11,
            color: textColor,
            fontWeight: FontWeightResources.bold,
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
        return Theme.of(context).extension<ExtraColors>()!.green.darker(0.3);
      } else {
        return Theme.of(context).extension<ExtraColors>()!.orange.darker(0.3);
      }
    } else {
      return Theme.of(context).extension<ExtraColors>()!.red.darker(0.3);
    }
  }

  Widget _buildMainInfo(BuildContext context, int percent, Color scoreColor) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'عنوان الدرس',
          style: AppTextStyles.caption.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(160),
            fontSize: FontSizeResources.s10,
          ),
        ),
        const SizedBox(height: SpacesResources.s2),
        Text(
          result.lessonTitle ?? 'اختبار مخصص',
          style: AppTextStyles.cardMediumTitle.copyWith(color: theme.colorScheme.onSurface),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: SpacesResources.s3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: FontSizeResources.s10,
              color: theme.colorScheme.onSurface.withAlpha(100),
            ),
            const SizedBox(width: SpacesResources.s2),
            Text(
              result.createdAt.toLocal().toIso8601String().split('T').first,
              style: AppTextStyles.caption.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(160),
              ),
            ),
            const SizedBox(width: SpacesResources.s4),
            Icon(
              Icons.timer_rounded,
              size: FontSizeResources.s10,
              color: theme.colorScheme.onSurface.withAlpha(100),
            ),
            const SizedBox(width: SpacesResources.s2),
            Text(
              _formatDuration(result.durationSeconds),
              style: AppTextStyles.caption.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(160),
              ),
            ),
          ],
        ),
        // Bottom stat row removed (compact design)
      ],
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) return '${minutes}m ${secs}s';
    return '${secs}s';
  }
}
