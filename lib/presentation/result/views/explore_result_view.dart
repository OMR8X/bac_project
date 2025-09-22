import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/core/widgets/messages/sheets/app_bottom_sheet.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/retry_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_by_ids_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_by_ids_use_case.dart';
import 'package:bac_project/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/orderable_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/textual_options_builder_widget.dart';
import 'package:bac_project/presentation/result/bloc/submit_results/explore_result_bloc.dart';
import 'package:bac_project/presentation/result/widgets/previous_results_list_card_widget.dart';
import 'package:bac_project/presentation/result/widgets/score_gauge_widget.dart';
import 'package:bac_project/presentation/result/widgets/state_chip_widget.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/messages/dialogs/conform_dialog.dart';
import '../../../features/tests/domain/entities/question_category.dart';
import '../../quizzing/blocs/quizzing_bloc.dart';

class ExploreResultView extends StatefulWidget {
  final ExploreResultViewArguments arguments;

  const ExploreResultView({super.key, required this.arguments});

  @override
  State<ExploreResultView> createState() => _ExploreResultViewState();
}

class _ExploreResultViewState extends State<ExploreResultView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreResultBloc>().add(
        ExploreResultInitialize(resultId: widget.arguments.resultId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.resultTitle),
        leading: CloseIconWidget(),
        actions: [
          RetryIconWidget(
            onPressed: () {
              showConformDialog(
                context: context,
                title: context.l10n.resultRetryTestDialogTitle,
                body: context.l10n.resultRetryTestDialogBody,
                action: context.l10n.buttonsRetryTest,
                onConform: () {
                  context.pushReplacement(
                    AppRoutes.fetchCustomQuestions.path,
                    extra: FetchCustomQuestionsArguments(resultId: widget.arguments.resultId),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: Paddings.screenSidesPadding,
        child: BlocConsumer<ExploreResultBloc, ExploreResultState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == ExploreResultStatus.loaded) {
              return _ExploreResultDetailsView(state: state, arguments: widget.arguments);
            } else if (state.status == ExploreResultStatus.failure) {
              return _ExploreResultFailureView(
                state: state,
                onRetry: () {
                  context.read<ExploreResultBloc>().add(const ExploreResultLoadResultDetails());
                },
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}

class _ExploreResultDetailsView extends StatelessWidget {
  const _ExploreResultDetailsView({required this.state, required this.arguments});
  final ExploreResultViewArguments arguments;
  final ExploreResultState state;

  @override
  Widget build(BuildContext context) {
    final intScore = state.response!.result.score.clamp(0, 100);

    return SingleChildScrollView(
      padding: Paddings.listViewPadding,
      child: Column(
        spacing: SpacesResources.s2,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Score gauge
          StaggeredItemWrapperWidget(
            position: 0,
            child: ScoreGauge(
              percentage: intScore / 100,
              displayText: '${intScore.toStringAsFixed(0)}%',
              correctAnswers: state.response!.result.correctAnswers,
              wrongAnswers: state.response!.result.wrongAnswers,
              skippedAnswers: 0,
              timeTaken: Duration(seconds: state.response!.result.durationSeconds),
              fullTime: Duration(seconds: state.response!.result.durationSeconds * 2),
            ),
          ),
          SizedBox(height: SpacesResources.s10),

          ///
          StaggeredItemWrapperWidget(
            position: 1,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: StatChip(
                          iconPath: UIImagesResources.checkRoundedUIIcon,
                          title: '${state.response!.result.correctAnswers}',
                          subtitle: context.l10n.resultCorrect,
                          iconColor: Theme.of(context).extension<ExtraColors>()!.green,
                        ),
                      ),

                      Expanded(
                        child: StatChip(
                          iconPath: UIImagesResources.arrowSquareOutUIIcon,
                          title: '${state.response!.result.totalQuestions}',
                          subtitle: context.l10n.resultsCount,
                          onTap: () {
                            showAppBottomSheet(
                              context: context,
                              child: QuestionsSheetBuilder(
                                questionAnswers: state.response!.result.questionAnswers,
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(
                        child: StatChip(
                          iconPath: UIImagesResources.cancelRoundedUIIcon,
                          title: '${state.response!.result.wrongAnswers}',
                          subtitle: context.l10n.resultWrong,
                          iconColor: Theme.of(context).extension<ExtraColors>()!.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Previous results
          StaggeredItemWrapperWidget(
            position: 3,
            child: PreviousResultsListCardWidget(results: state.response!.previousResults ?? []),
          ),
        ],
      ),
    );
  }
}

// Failure State View Template
class _ExploreResultFailureView extends StatelessWidget {
  const _ExploreResultFailureView({required this.state, required this.onRetry});

  final ExploreResultState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ErrorStateBodyWidget(
      title: 'فشل في الحصول على النتيجة',
      failure: state.failure!,
      onRetry: onRetry,
      onCancel: () => Navigator.of(context).pop(),
    );
  }
}

class QuestionsSheetBuilder extends StatefulWidget {
  const QuestionsSheetBuilder({super.key, required this.questionAnswers});
  final List<QuestionAnswer> questionAnswers;

  @override
  State<QuestionsSheetBuilder> createState() => _QuestionsSheetBuilderState();
}

class _QuestionsSheetBuilderState extends State<QuestionsSheetBuilder> {
  late Failure? _failure;
  late bool _isLoading;
  late List<Question> _questions;

  @override
  void initState() {
    ///
    _isLoading = true;
    _failure = null;
    _questions = [];

    ///
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchQuestions();
    });
    super.initState();
  }

  Future<void> _fetchQuestions() async {
    //
    setState(() => _isLoading = true);
    //
    final response = await sl<GetQuestionsByIdsUsecase>().call(
      GetQuestionsByIdsRequest(
        questionIds: widget.questionAnswers.map((e) => e.questionId).toList(),
      ),
    );
    //
    response.fold((l) => _failure = l, (r) {
      _failure = null;
      _questions = r.questions;
    });
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingWidget();
    }
    if (_failure != null) {
      return ErrorStateBodyWidget(
        title: "خطأ في الحصول على الاسئلة",
        failure: _failure,
        onRetry: () {
          setState(() => _isLoading = true);
          _fetchQuestions();
        },
      );
    }

    return Column(
      children: [
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: Paddings.listViewPadding,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return StaggeredListWrapperWidget(
                  position: index,
                  child: Column(
                    children: [
                      QuestionCardWidget(question: _questions[index]),
                      _buildOptions(
                        context: context,
                        question: _questions[index],
                        questionAnswers: widget.questionAnswers,
                        testMode: TestMode.exploring,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: SizesResources.buttonLargeHeight,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.buttonsClose),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptions({
    required BuildContext context,
    required Question question,
    required List<QuestionAnswer> questionAnswers,
    required TestMode testMode,
  }) {
    ///
    final QuestionCategory? category = sl<AppSettings>().categories.firstWhereOrNull(
      (c) => c.id == question.categoryId,
    );

    ///
    if (category?.isMCQ ?? false) {
      return MultipleChoicesQuestionBuilderWidget(
        question: question,
        questionsAnswers: questionAnswers,
      );
    } else if (category?.isOrderable ?? false) {
      return OrderableQuestionBuilderWidget(question: question, questionsAnswers: questionAnswers);
    } else if ((category?.isTypeable) ?? false) {
      return TextualQuestionsBuilderWidget(question: question, questionsAnswers: questionAnswers);
    } else if ((category?.isSingleAnswer) ?? false) {
      return TextualQuestionsBuilderWidget(question: question, questionsAnswers: questionAnswers);
    } else {
      return const SizedBox.shrink();
    }
  }
}
