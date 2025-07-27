import 'package:flutter/material.dart';
import 'package:bac_project/presentation/result/models/custom_result_card_model.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';

class ResultCardWidget extends StatelessWidget {
  final CustomResultCardData result;

  const ResultCardWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Parse score to determine color
    final scoreValue = _parseScore(result.score);
    final scoreColor = _getScoreColor(scoreValue);

    return Card(
      margin: PaddingResources.cardOuterPadding,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Handle tap if needed
        },
        child: Padding(
          padding: PaddingResources.cardMediumInnerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ResultCardHeader(
                title: result.title,
                score: result.score,
                scoreColor: scoreColor,
              ),
              const SizedBox(height: 12),
              _ResultCardDetails(
                date: result.date,
                scoreValue: scoreValue,
                scoreColor: scoreColor,
                getPerformanceIcon: _getPerformanceIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _parseScore(String score) {
    final parts = score.split('/');
    if (parts.isNotEmpty) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  Color _getScoreColor(int score) {
    if (score >= 85) {
      return Colors.green;
    } else if (score >= 70) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  IconData _getPerformanceIcon(int score) {
    if (score >= 85) {
      return Icons.trending_up_rounded;
    } else if (score >= 70) {
      return Icons.trending_flat_rounded;
    } else {
      return Icons.trending_down_rounded;
    }
  }
}

class _ResultCardHeader extends StatelessWidget {
  const _ResultCardHeader({
    super.key,
    required this.title,
    required this.score,
    required this.scoreColor,
  });

  final String title;
  final String score;
  final Color scoreColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.cardMediumTitle.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: scoreColor.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scoreColor.withAlpha(75), width: 1),
          ),
          child: Text(
            score,
            style: AppTextStyles.cardSmallTitle.copyWith(
              color: scoreColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultCardDetails extends StatelessWidget {
  const _ResultCardDetails({
    super.key,
    required this.date,
    required this.scoreValue,
    required this.scoreColor,
    required this.getPerformanceIcon,
  });

  final String date;
  final int scoreValue;
  final Color scoreColor;
  final IconData Function(int) getPerformanceIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: 16,
          color: theme.colorScheme.onSurface.withAlpha(153),
        ),
        const SizedBox(width: 6),
        Text(
          date,
          style: AppTextStyles.cardSmallSubtitle.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(178),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
