import 'package:flutter/material.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/presentation/tests/blocs/quizzing_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizzingResultView extends StatelessWidget {
  const QuizzingResultView({super.key, required this.state});

  final QuizzingResult state;

  Color _scoreColor(double percentage) {
    if (percentage >= 85) return Colors.green;
    if (percentage >= 70) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scorePercent = (state.score.clamp(0, 100)) / 100.0;
    final scoreColor = _scoreColor(state.score);

    return SafeArea(
      child: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: SpacesResources.s8),
                    Center(
                      child: Text(
                        context.l10n.resultTitle,
                        style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.onSurface),
                      ),
                    ),
                    const SizedBox(height: SpacesResources.s8),

                    /// Score gauge
                    _ScoreGauge(
                      percentage: scorePercent,
                      displayText: '${state.score.toStringAsFixed(0)}%',
                      color: scoreColor,
                    ),
                    const SizedBox(height: SpacesResources.s8),

                    /// Breakdown row
                    Row(
                      children: [
                        Expanded(
                          child: _StatChip(
                            icon: Icons.check_circle_rounded,
                            label: context.l10n.resultCorrect,
                            value: '${state.correctAnswers}',
                            color: Colors.green,
                            theme: theme,
                          ),
                        ),
                        const SizedBox(width: SpacesResources.s3),
                        Expanded(
                          child: _StatChip(
                            icon: Icons.cancel_rounded,
                            label: context.l10n.resultWrong,
                            value: '${state.wrongAnswers}',
                            color: Colors.red,
                            theme: theme,
                          ),
                        ),
                        const SizedBox(width: SpacesResources.s3),
                        Expanded(
                          child: _StatChip(
                            icon: Icons.help_outline_rounded,
                            label: context.l10n.resultUnanswered,
                            value: '${state.unansweredQuestions}',
                            color: Colors.orange,
                            theme: theme,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpacesResources.s4),

                    /// Time taken
                    _TimeTakenCard(timeTaken: state.timeTaken),

                    const SizedBox(height: SpacesResources.s8),
                  ],
                ),
              ),
            ),

            /// Bottom actions
            Padding(
              padding: const EdgeInsets.only(bottom: SpacesResources.s4, top: SpacesResources.s2),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        context.l10n.buttonsClose,
                        style: AppTextStyles.button.copyWith(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                  const SizedBox(width: SpacesResources.s4),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                      ),
                      onPressed: () => context.read<QuizzingBloc>().add(const RetakeQuiz()),
                      child: Text(context.l10n.buttonsRetry, style: AppTextStyles.button),
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
}

class _ScoreGauge extends StatelessWidget {
  const _ScoreGauge({required this.percentage, required this.displayText, required this.color});

  final double percentage;
  final String displayText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 180,
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 10,
                backgroundColor: theme.colorScheme.outlineVariant.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayText,
                  style: AppTextStyles.largeTitle.copyWith(color: theme.colorScheme.onSurface),
                ),
                const SizedBox(height: SpacesResources.s2),
                Text(
                  context.l10n.resultScore,
                  style: AppTextStyles.cardSmallSubtitle.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withAlpha(20),
      shape: RoundedSuperellipseBorder(
        side: BorderSide(color: color.withAlpha(100)),
        borderRadius: BorderRadiusResource.cardBorderRadius,
      ),
      child: Padding(
        padding: PaddingResources.cardMediumInnerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardLargeTitle.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardSmallSubtitle.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
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
}

// MDC: Time taken card (reuses card styling instead of a plain Container)
class _TimeTakenCard extends StatelessWidget {
  const _TimeTakenCard({required this.timeTaken});

  final Duration timeTaken;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minutes = timeTaken.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = timeTaken.inSeconds.remainder(60).toString().padLeft(2, '0');
    final timeText = '$minutes:$seconds';
    return Card(
      margin: PaddingResources.cardOuterPadding,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: PaddingResources.cardMediumInnerPadding,
        child: Row(
          children: [
            Icon(Icons.timer_outlined, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: SpacesResources.s4),
            Text(
              timeText,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.cardLargeTitle.copyWith(color: theme.colorScheme.onSurface),
            ),
            const SizedBox(width: SpacesResources.s3),
            Text(
              context.l10n.resultTimeTaken,
              style: AppTextStyles.cardSmallSubtitle.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
