// import 'package:bac_project/presentation/result/widgets/score_gauge_widget.dart';
// import 'package:bac_project/presentation/result/widgets/state_chip_widget.dart';
// import 'package:bac_project/presentation/result/widgets/time_taken_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
// import 'package:bac_project/core/extensions/build_context_l10n.dart';
// import 'package:bac_project/core/resources/styles/padding_resources.dart';
// import 'package:bac_project/core/resources/styles/spaces_resources.dart';
// import 'package:bac_project/core/resources/styles/sizes_resources.dart';
// import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
// import 'package:bac_project/presentation/tests/blocs/quizzing_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class QuizzingResultView extends StatelessWidget {
//   const QuizzingResultView({super.key, required this.state});

//   final QuizzingResult state;

//   Color _scoreColor(double percentage) {
//     if (percentage >= 85) return Colors.green;
//     if (percentage >= 70) return Colors.orange;
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final scorePercent = (state.score.clamp(0, 100)) / 100.0;
//     final scoreColor = _scoreColor(state.score);

//     return SafeArea(
//       child: Padding(
//         padding: PaddingResources.screenSidesPadding,
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: SpacesResources.s8),
//                     Center(
//                       child: Text(
//                         context.l10n.resultTitle,
//                         style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.onSurface),
//                       ),
//                     ),
//                     const SizedBox(height: SpacesResources.s8),

//                     /// Score gauge
//                     ScoreGauge(
//                       percentage: scorePercent,
//                       displayText: '${state.score.toStringAsFixed(0)}%',
//                       color: scoreColor,
//                     ),
//                     const SizedBox(height: SpacesResources.s8),

//                     /// Breakdown row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: StatChip(
//                             icon: Icons.check_circle_rounded,
//                             label: context.l10n.resultCorrect,
//                             value: '${state.correctAnswers}',
//                             color: Colors.green,
//                             theme: theme,
//                           ),
//                         ),
//                         const SizedBox(width: SpacesResources.s3),
//                         Expanded(
//                           child: StatChip(
//                             icon: Icons.cancel_rounded,
//                             label: context.l10n.resultWrong,
//                             value: '${state.wrongAnswers}',
//                             color: Colors.red,
//                             theme: theme,
//                           ),
//                         ),
//                         const SizedBox(width: SpacesResources.s3),
//                         Expanded(
//                           child: StatChip(
//                             icon: Icons.help_outline_rounded,
//                             label: context.l10n.resultUnanswered,
//                             value: '${state.skippedAnswers}',
//                             color: Colors.orange,
//                             theme: theme,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: SpacesResources.s4),

//                     /// Time taken
//                     TimeTakenCard(timeTaken: state.timeTaken),

//                     const SizedBox(height: SpacesResources.s8),
//                   ],
//                 ),
//               ),
//             ),

//             /// Bottom actions
//             Padding(
//               padding: const EdgeInsets.only(bottom: SpacesResources.s4, top: SpacesResources.s2),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
//                       ),
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: Text(
//                         context.l10n.buttonsClose,
//                         style: AppTextStyles.button.copyWith(color: theme.colorScheme.onSurface),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: SpacesResources.s4),
//                   Expanded(
//                     child: FilledButton(
//                       style: FilledButton.styleFrom(
//                         minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
//                       ),
//                       onPressed: () => context.read<QuizzingBloc>().add(const RetakeQuiz()),
//                       child: Text(context.l10n.buttonsRetryTest, style: AppTextStyles.button),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
