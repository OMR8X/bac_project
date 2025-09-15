import 'dart:math' as math;

import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:flutter/material.dart';

class ScoreGauge extends StatelessWidget {
  const ScoreGauge({
    super.key,
    required this.percentage,
    required this.displayText,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
    required this.timeTaken,
    required this.fullTime,
  });

  final double percentage;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;
  final String displayText;
  final Duration timeTaken;
  final Duration fullTime;
  @override
  Widget build(BuildContext context) {
    final String timeTakenLabel = _formatDuration(timeTaken);
    final String fullTimeLabel = _formatDuration(fullTime);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: SpacesResources.s20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth / 2.25,
            child: CustomPaint(
              painter: ArcGaugePainter(
                percentage: percentage,
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onSurface,
                strokeWidth: 36,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: SpacesResources.s10),
                  Text(
                    " $displayText  ",
                    style: TextStylesResources.largeTitle.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeightResources.black,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: timeTakenLabel,
                          style: TextStylesResources.subTitle.copyWith(
                            fontSize: FontSizeResources.s12,
                            color: theme.extension<ExtraColors>()!.primaryState[500]!,
                            fontWeight: FontWeightResources.medium,
                          ),
                        ),
                        TextSpan(
                          text: ' / ',
                          style: TextStylesResources.subTitle.copyWith(
                            fontSize: FontSizeResources.s12,
                            color: theme.extension<ExtraColors>()!.primaryState[400]!,
                            fontWeight: FontWeightResources.bold,
                          ),
                        ),

                        TextSpan(
                          text: fullTimeLabel,
                          style: TextStylesResources.subTitle.copyWith(
                            fontSize: FontSizeResources.s12,
                            color: theme.extension<ExtraColors>()!.primaryState[400]!,
                            fontWeight: FontWeightResources.regular,
                          ),
                        ),

                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 1.5, right: 2),
                            child: Image.asset(
                              UIImagesResources.timerUIIcon,
                              height: FontSizeResources.s12,
                              color: theme.extension<ExtraColors>()!.primaryState[400]!,
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
        },
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
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}

class ArcGaugePainter extends CustomPainter {
  ArcGaugePainter({
    required this.percentage,
    required this.backgroundColor,
    required this.foregroundColor,
    this.strokeWidth = 22.0,
  });

  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.bottomCenter(Offset.zero);
    final radius = size.shortestSide;

    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

    final foregroundPaint =
        Paint()
          ..color = foregroundColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);
    const paddingAmount = 0;
    const startAngle = 0.0 + (paddingAmount) / 2;
    final sweepBackground = math.pi + (paddingAmount);
    final sweepForeground = (math.pi * (percentage.clamp(0.0, 1.0))) + (paddingAmount);

    canvas.drawArc(rect, startAngle, -sweepBackground, false, backgroundPaint);
    canvas.drawArc(rect, startAngle, -sweepForeground, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant ArcGaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
