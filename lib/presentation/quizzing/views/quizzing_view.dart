import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/animations/skeletonizer_effect_list_wraper.dart';
import 'package:bac_project/core/widgets/messages/dialogs/conform_dialog.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:bac_project/presentation/result/bloc/explore_results/explore_results_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
// spaces resources not needed here
import 'package:bac_project/presentation/quizzing/blocs/quizzing_bloc.dart';
import 'package:bac_project/presentation/quizzing/views/quizzing_answer_view.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:go_router/go_router.dart';

class QuizzingView extends StatelessWidget {
  const QuizzingView({super.key, this.arguments});

  final QuizzingArguments? arguments;

  @override
  Widget build(BuildContext context) {
    final questions = arguments?.questions ?? <dynamic>[];

    return BlocProvider<QuizzingBloc>(
      create:
          (_) =>
              QuizzingBloc()..add(
                InitializeQuiz(
                  questions: questions.cast(),
                  timeLimit: arguments?.timeLimit ?? 30,
                  lessonId:
                      arguments?.lessonIds?.length == 1 ? arguments!.lessonIds!.firstOrNull : null,
                  testMode: arguments?.testMode ?? TestMode.exploring,
                ),
              ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: Paddings.screenSidesPadding,
            child: BlocConsumer<QuizzingBloc, QuizzingState>(
              buildWhen: (previous, current) {
                if (previous.runtimeType != current.runtimeType) {
                  return true;
                }
                if (previous is QuizzingAnswerQuestion && current is QuizzingAnswerQuestion) {
                  return previous.currentQuestion != current.currentQuestion;
                }
                return false;
              },
              listener: (context, state) {
                if (state is QuizzingResultUploaded) {
                  sl<ExploreResultsBloc>().add(RefreshResults());
                  context.pushReplacement(
                    Routes.exploreResult.path,
                    extra: ExploreResultViewArguments(resultId: state.result.id),
                  );
                }
              },
              builder: (context, state) {
                if (state is QuizzingLoading) return const _QuizzingLoadingView();
                if (state is QuizzingUploadingResult) return _QuizzingUploadingResultView();
                if (state is QuizzingFailedUploadingResult) {
                  return ErrorStateBodyWidget(
                    title: 'Failed to Upload Result',
                    failure: state.failure,
                    onRetry: () {
                      context.read<QuizzingBloc>().add(const RetryUploadResult());
                    },
                    onCancel: () {
                      context.pop();
                    },
                  );
                }

                if (state is QuizzingAnswerQuestion) {
                  return QuizzingAnswerView(
                    state: state,
                    testMode: arguments?.testMode ?? TestMode.testing,
                    onClose: () {
                      showConformDialog(
                        context: context,
                        onConform: () => context.read<QuizzingBloc>().add(const SubmitQuiz()),
                        title: context.l10n.closeQuizDialogTitle,
                        body: context.l10n.closeQuizDialogBody,
                        action: context.l10n.buttonsConfirm,
                      );
                    },
                    onNextOrSubmit: () {
                      if (state.canGoNext) {
                        context.read<QuizzingBloc>().add(const NextQuestion());
                      } else {
                        context.read<QuizzingBloc>().add(const SubmitQuiz());
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizzingLoadingView extends StatelessWidget {
  const _QuizzingLoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.screenSidesPadding,
      child: SkeletonizerEffectListWrapper.loading(
        child: Column(
          children: [
            QuestionCardWidget(
              question: Question.mock(),
            ),
            MultipleChoicesQuestionBuilderWidget(
              question: Question.mock(),
              questionsAnswers: [],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizzingUploadingResultView extends StatelessWidget {
  const _QuizzingUploadingResultView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.screenSidesPadding,
      child: Center(
        child: CupertinoActivityIndicator(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
