import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bac_project/presentation/tests/widgets/quizzing_answer_top_controls.dart';
import 'package:bac_project/presentation/tests/widgets/quizzing_answer_navigation.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/presentation/tests/blocs/quizzing/quizzing_bloc.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:bac_project/presentation/tests/widgets/option_card_widget.dart';
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
            Expanded(
              child: ListView(
                padding: PaddingResources.listViewPadding,
                children: [
                  QuestionCardWidget(question: question),
                  const SizedBox(height: SpacesResources.s2),
                  ..._buildOptions(context, question, state, testMode),
                ],
              ),
            ),
          ],
        ),
        // Only show navigation when user has selected an answer for current question
        if (state.selectedAnswers[question.id] != null || testMode == TestMode.exploring || kDebugMode)
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StaggeredItemWrapperWidget(
                position: 1,
                child: QuizzingAnswerNavigation(
                  canGoPrevious: state.canGoPrevious,
                  canGoNext: state.canGoNext,
                  onPrevious: () => context.read<QuizzingBloc>().add(const PreviousQuestion()),
                  onNextOrSubmit: () {
                    if (state.canGoNext) {
                      context.read<QuizzingBloc>().add(const NextQuestion());
                    } else {
                      context.read<QuizzingBloc>().add(const SubmitQuiz());
                    }
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildOptions(BuildContext context, dynamic question, QuizzingAnswerQuestion state, TestMode testMode) {
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
          onTap: (opt) => context.read<QuizzingBloc>().add(OptionQuestion(answerId: opt.id, questionIndex: state.currentQuestionIndex)),
        ),
      );
    }).toList();
  }
}
