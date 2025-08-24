import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/injector/app_injection.dart';

import 'package:bac_project/presentation/tests/widget/quizzing_answer_top_controls.dart';
import 'package:bac_project/presentation/tests/widget/quizzing_answer_navigation.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/presentation/tests/blocs/quizzing_bloc.dart';
import 'package:bac_project/presentation/tests/widget/question_card_widget.dart';
import 'package:bac_project/presentation/tests/widget/option_card_widget.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

class QuizzingAnswerView extends StatelessWidget {
  const QuizzingAnswerView({super.key, required this.state, required this.testMode});

  final QuizzingAnswerQuestion state;
  final TestMode testMode;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpacesResources.s4),
            QuizzingAnswerTopControls(
              timeLeft: state.timeLeft,
              current: state.currentQuestionIndex + 1,
              total: state.totalQuestions,
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: SpacesResources.s4),
            QuestionCardWidget(question: question),
            const SizedBox(height: SpacesResources.s2),
            ..._buildOptions(context, question, state, testMode),
          ],
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: QuizzingAnswerNavigation(
              canGoPrevious: state.canGoPrevious,
              canGoNext: state.canGoNext,
              onPrevious: () => context.read<QuizzingBloc>().add(const PreviousQuestion()),
              onNextOrSubmit: () {
                if (state.canGoNext)
                  context.read<QuizzingBloc>().add(const NextQuestion());
                else
                  context.read<QuizzingBloc>().add(const SubmitQuiz());
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildOptions(
    BuildContext context,
    dynamic question,
    QuizzingAnswerQuestion state,
    TestMode testMode,
  ) {
    return question.options.map<Widget>((option) {
      final selectedForQuestion = state.selectedAnswers[question.id];
      final isSelected = selectedForQuestion == option.id;
      final didAnswer = selectedForQuestion != null;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: OptionCardWidget(
          key: Key('${question.id}-${option.id}'),
          option: option,
          isSelected: isSelected,
          didAnswer: didAnswer,
          testMode: testMode,
          onTap:
              (opt) => context.read<QuizzingBloc>().add(
                OptionQuestion(
                  answerId: opt.id,
                  questionIndex: state.currentQuestionIndex,
                ),
              ),
        ),
      );
    }).toList();
  }
}

class _TopControls extends StatelessWidget {
  const _TopControls({
    required this.timeLeft,
    required this.current,
    required this.total,
    required this.onClose,
  });

  final Duration timeLeft;
  final int current;
  final int total;
  final VoidCallback onClose;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _pad2(int value) => value.toString().padLeft(2, '0');

  String _formatQuestionCount(int current, int total) => '${_pad2(current)}/${_pad2(total)}';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // center: timer exactly centered
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(_formatDuration(timeLeft), style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),

        // left: question count
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _formatQuestionCount(current, total),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),

        // right: close
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.close,
                size: 18,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onNextOrSubmit,
  });

  final bool canGoPrevious;
  final bool canGoNext;
  final VoidCallback onPrevious;
  final VoidCallback onNextOrSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
              ),
              onPressed: canGoPrevious ? onPrevious : null,
              child: Text(
                context.l10n.buttonsPrevious,
                style: TextStyle(
                  color:
                      canGoPrevious
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: SpacesResources.s3),
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
              ),
              onPressed: onNextOrSubmit,
              child: Text(context.l10n.buttonsNext),
            ),
          ),
        ],
      ),
    );
  }
}
