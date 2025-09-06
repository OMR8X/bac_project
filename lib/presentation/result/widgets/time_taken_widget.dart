import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/padding_resources.dart';

/// A compact, themed card showing time taken vs full time with an icon and progress.
class TimeTakenCard extends StatelessWidget {
  const TimeTakenCard({super.key, required this.timeTaken, required this.fullTime});

  final Duration timeTaken;
  final Duration fullTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double progress =
        (fullTime.inMilliseconds > 0) ? timeTaken.inMilliseconds / fullTime.inMilliseconds : 0.0;
    final String timeTakenLabel = _formatDuration(timeTaken);
    final String fullTimeLabel = _formatDuration(fullTime);

    return Card(
      margin: PaddingResources.cardOuterPadding,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Leading icon
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     color: theme.colorScheme.primaryContainer,
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(Icons.timer, color: theme.colorScheme.onSurfaceVariant),
            // ),
            AppBarIconWidget(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.timer, size: 18, color: theme.colorScheme.onSurface.lighter(0.4)),
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            // Textual information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Removed the textual label to rely on the icon for context
                  Row(
                    children: [
                      Text(
                        timeTakenLabel,
                        style:
                            theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ) ??
                            theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '/ $fullTimeLabel',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress indicator with rounded ends
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.onSurface.lighter(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '$minutes:${twoDigits(seconds)}';
    }
  }
}
