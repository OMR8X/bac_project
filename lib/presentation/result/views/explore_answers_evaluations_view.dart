import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/loading_state_body_widget.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/l10n/generated/app_localizations.dart';
import 'package:bac_project/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/orderable_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/textual_options_builder_widget.dart';
import 'package:bac_project/presentation/result/bloc/explore_answers_evaluations/explore_answers_evaluations_bloc.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExploreAnswersEvaluationsView extends StatelessWidget {
  final ExploreAnswersEvaluationsViewArguments arguments;

  const ExploreAnswersEvaluationsView({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.answerEvaluationsTitle)),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: BlocProvider(
          create:
              (context) =>
                  ExploreAnswersEvaluationsBloc()
                    ..add(InitializeAnswersEvaluationsBloc(resultId: arguments.resultId)),
          child: BlocBuilder<ExploreAnswersEvaluationsBloc, ExploreAnswersEvaluationsState>(
            builder: (context, state) {
              switch (state.status) {
                case ExploreAnswersEvaluationsStatus.loading:
                  return const LoadingStateBodyWidget();
                case ExploreAnswersEvaluationsStatus.loaded:
                  return _ExploreAnswersEvaluationsLoadedView(state: state);
                case ExploreAnswersEvaluationsStatus.failure:
                  return ErrorStateBodyWidget(
                    title: 'Error Loading Answer Evaluations',
                    failure: state.failure,
                    onRetry: () {
                      context.read<ExploreAnswersEvaluationsBloc>().add(
                        InitializeAnswersEvaluationsBloc(resultId: arguments.resultId),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _ExploreAnswersEvaluationsLoadedView extends StatelessWidget {
  const _ExploreAnswersEvaluationsLoadedView({required this.state});

  final ExploreAnswersEvaluationsState state;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: Paddings.listViewPadding,
        itemCount: state.questions?.length ?? 0,
        itemBuilder: (context, index) {
          final question = state.questions![index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Column(
                  children: [
                    QuestionCardWidget(question: question),
                    _buildOptions(context: context, question: question),
                    // SizedBoxes.s2v,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptions({required BuildContext context, required dynamic question}) {
    final QuestionCategory? category = sl<AppSettings>().categories.firstWhereOrNull(
      (c) => c.id == question.categoryId,
    );

    if (category?.isMCQ ?? false) {
      return MultipleChoicesQuestionBuilderWidget(
        question: question,
        questionsAnswers: question.questionAnswers,
        answerEvaluations: question.answerEvaluations,
      );
    } else if (category?.isOrderable ?? false) {
      return OrderableQuestionBuilderWidget(
        question: question,
        questionsAnswers: question.questionAnswers,
        answerEvaluations: question.answerEvaluations,
      );
    } else if ((category?.isTypeable) ?? false) {
      return TextualQuestionsBuilderWidget(
        question: question,
        questionsAnswers: question.questionAnswers,
        answerEvaluations: question.answerEvaluations,
      );
    } else if ((category?.isSingleAnswer) ?? false) {
      return TextualQuestionsBuilderWidget(
        question: question,
        questionsAnswers: question.questionAnswers,
        answerEvaluations: question.answerEvaluations,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
