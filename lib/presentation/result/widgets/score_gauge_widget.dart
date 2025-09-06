import 'dart:math' as math;

import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class ScoreGauge extends StatelessWidget {
  const ScoreGauge({
    super.key,
    required this.percentage,
    required this.displayText,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
  });

  final double percentage;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(SpacesResources.s20),
          child: SizedBox(
            height: 150,
            width: 150,
            child: CustomPaint(
              painter: ArcGaugePainter(
                percentage: percentage,
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.primary,
                strokeWidth: 24,
              ),
              child: Align(
                alignment: Alignment(0, 1.25),
                child: Text(
                  "$displayText  ",
                  style: AppTextStyles.largeTitle.copyWith(fontSize: 48),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ArcGaugePainter extends CustomPainter {
  ArcGaugePainter({
    required this.percentage,
    required this.backgroundColor,
    required this.foregroundColor,
    this.strokeWidth = 16.0,
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
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final foregroundPaint =
        Paint()
          ..color = foregroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    const paddingAmount = (math.pi / 10);
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
