import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:flutter/material.dart';

class AnswersDetailsIndicatorWidget extends StatelessWidget {
  const AnswersDetailsIndicatorWidget({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
  });

  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int safeTotal =
        totalQuestions <= 0 ? (correctAnswers + wrongAnswers + skippedAnswers) : totalQuestions;

    final int safeCorrect = correctAnswers.clamp(0, safeTotal);
    final int safeWrong = wrongAnswers.clamp(0, safeTotal);
    final int safeSkipped = skippedAnswers.clamp(0, safeTotal);
    final Color colorCorrect = theme.colorScheme.primary;
    final Color colorWrong = theme.colorScheme.error;
    final Color colorSkipped = theme.extension<ExtraColors>()!.orange;

    final int sumParts = safeCorrect + safeWrong + safeSkipped;

    // Avoid divide-by-zero; show empty track when nothing to display
    final double correctFraction = sumParts == 0 ? 0 : safeCorrect / sumParts;
    final double wrongFraction = sumParts == 0 ? 0 : safeWrong / sumParts;
    final double skippedFraction = sumParts == 0 ? 0 : safeSkipped / sumParts;

    // Convert to flex values with a minimum of 0
    int toFlex(double fraction) => (fraction * 1000).round();
    final int correctFlex = toFlex(correctFraction);
    final int wrongFlex = toFlex(wrongFraction);
    final int skippedFlex = toFlex(skippedFraction);

    return Card(
      child: Padding(
        padding: Paddings.cardLargePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (correctFlex > 0)
                        Expanded(flex: correctFlex, child: Container(color: colorCorrect)),
                      if (skippedFlex > 0)
                        Expanded(flex: skippedFlex, child: Container(color: colorSkipped)),
                      if (wrongFlex > 0)
                        Expanded(flex: wrongFlex, child: Container(color: colorWrong)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpacesResources.s3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LegendIcon(label: '$safeCorrect', color: colorCorrect, icon: Icons.check),
                _LegendIcon(label: '$safeSkipped', color: colorSkipped, icon: Icons.remove),
                _LegendIcon(label: '$safeWrong', color: colorWrong, icon: Icons.close),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendIcon extends StatelessWidget {
  const _LegendIcon({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: SpacesResources.s2),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
