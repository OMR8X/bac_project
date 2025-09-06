import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/ui/fields/mode_switcher_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/presentation/result/bloc/submit_results/explore_result_bloc.dart';
import 'package:bac_project/presentation/result/widgets/category_performance_widget.dart';
import 'package:bac_project/presentation/result/widgets/previous_results_list_card_widget.dart';
import 'package:bac_project/presentation/result/widgets/score_gauge_widget.dart';
import 'package:bac_project/presentation/result/widgets/state_chip_widget.dart';
import 'package:bac_project/presentation/result/widgets/leaderboard_item_card_widget.dart';
import 'package:bac_project/presentation/result/widgets/time_taken_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreResultView extends StatefulWidget {
  final ExploreResultViewArguments arguments;

  const ExploreResultView({super.key, required this.arguments});

  @override
  State<ExploreResultView> createState() => _ExploreResultViewState();
}

class _ExploreResultViewState extends State<ExploreResultView> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context.read<ExploreResultBloc>().add(const ExploreResultLoadResultDetails());
      } else {
        context.read<ExploreResultBloc>().add(const ExploreResultLoadResultLeaderboard());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreResultBloc>().add(
        ExploreResultInitialize(resultId: widget.arguments.resultId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExploreResultBloc, ExploreResultState>(
        listener: (context, state) {},
        builder: (context, state) {
          if ([
            ExploreResultStatus.loadingResultDetails,
            ExploreResultStatus.loadingResultLeaderboard,
            ExploreResultStatus.resultDetails,
            ExploreResultStatus.resultLeaderboard,
          ].contains(state.status)) {
            return Scaffold(
              appBar: AppBar(title: Text(context.l10n.resultTitle), leading: CloseIconWidget()),
              body: Padding(
                padding: PaddingResources.screenSidesPadding,
                child: Column(
                  children: [
                    ModeSwitcherWidget(
                      firstOption: SwitchOption(
                        value: context.l10n.buttonsResultDetailsTab,
                        label: context.l10n.buttonsResultDetailsTab,
                        icon: Icons.list,
                      ),
                      secondOption: SwitchOption(
                        value: context.l10n.buttonsResultLeaderboardTab,
                        label: context.l10n.buttonsResultLeaderboardTab,
                        icon: Icons.leaderboard,
                      ),
                      currentValue:
                          [
                                ExploreResultStatus.resultDetails,
                                ExploreResultStatus.loadingResultDetails,
                              ].contains(state.status)
                              ? context.l10n.buttonsResultDetailsTab
                              : context.l10n.buttonsResultLeaderboardTab,
                      onChanged: (value) {
                        if (value == context.l10n.buttonsResultDetailsTab) {
                          _tabController.index = 0;
                        } else {
                          _tabController.index = 1;
                        }
                      },
                    ),
                    Expanded(child: _getBody(state)),
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: PaddingResources.screenSidesPadding.add(
                    const EdgeInsets.only(bottom: SpacesResources.s4),
                  ),
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton(
                      //     style: OutlinedButton.styleFrom(
                      //       minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                      //     ),
                      //     onPressed: () => Navigator.of(context).pop(),
                      //     child: Text(
                      //       context.l10n.buttonsClose,
                      //       style: AppTextStyles.button.copyWith(
                      //         color: Theme.of(context).colorScheme.onSurface,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: SpacesResources.s4),
                      // Expanded(
                      //   child: FilledButton(
                      //     style: FilledButton.styleFrom(
                      //       minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                      //     ),
                      //     onPressed: () {
                      //       // Navigate to fetch custom questions with the result data
                      //       context.pushReplacement(
                      //         AppRoutes.fetchCustomQuestions.path,
                      //         extra: FetchCustomQuestionsArguments(result: state.result!),
                      //       );
                      //     },
                      //     child: Text(context.l10n.buttonsRetryTest, style: AppTextStyles.button),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                      //     ),
                      //     onPressed: () {
                      //       // Navigate to fetch custom questions with the result data
                      //       context.pushReplacement(
                      //         AppRoutes.fetchCustomQuestions.path,
                      //         extra: FetchCustomQuestionsArguments(result: state.response!.result),
                      //       );
                      //     },
                      //     child: Text(context.l10n.buttonsRetryTest, style: AppTextStyles.button),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.status == ExploreResultStatus.loadingDetailsFailure ||
              state.status == ExploreResultStatus.loadingLeaderboardFailure) {
            return _ExploreResultFailureView(
              state: state,
              onRetry: () {
                if (state.status == ExploreResultStatus.loadingDetailsFailure) {
                  context.read<ExploreResultBloc>().add(const ExploreResultLoadResultDetails());
                } else {
                  context.read<ExploreResultBloc>().add(const ExploreResultLoadResultLeaderboard());
                }
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _getBody(ExploreResultState state) {
    if (state.status == ExploreResultStatus.resultDetails) {
      return _ExploreResultDetailsView(state: state, arguments: widget.arguments);
    } else if (state.status == ExploreResultStatus.resultLeaderboard) {
      return _ExploreResultLeaderboardView(state: state);
    }
    return const LoadingWidget();
  }
}

class _ExploreResultDetailsView extends StatelessWidget {
  const _ExploreResultDetailsView({required this.state, required this.arguments});
  final ExploreResultViewArguments arguments;
  final ExploreResultState state;

  @override
  Widget build(BuildContext context) {
    final intScore = state.response!.result.score.clamp(0, 100).toInt();

    return SingleChildScrollView(
      padding: PaddingResources.listViewPadding,
      child: Column(
        spacing: SpacesResources.s2,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Score gauge
          TweenAnimationBuilder(
            tween: IntTween(begin: 0, end: intScore),
            builder: (context, value, child) {
              return ScoreGauge(
                percentage: value / 100,
                displayText: '${value.toStringAsFixed(0)}%',
                correctAnswers: state.response!.result.correctAnswers,
                wrongAnswers: state.response!.result.wrongAnswers,
                skippedAnswers: state.response!.result.skippedAnswers,
              );
            },
            duration: Duration(milliseconds: 600),
          ),

          /// Breakdown row
          const SizedBox(height: SpacesResources.s4),

          /// Breakdown row
          Row(
            children: [
              Expanded(
                child: StatChip(
                  icon: Icons.check_circle_rounded,
                  label: context.l10n.resultsCount,
                  value: '${state.response!.result.totalQuestions}',
                  color: Theme.of(context).colorScheme.primary,
                  onExplore: () {},
                ),
              ),
              Expanded(
                child: StatChip(
                  icon: Icons.check_circle_rounded,
                  label: context.l10n.resultCorrect,
                  value: '${state.response!.result.correctAnswers}',
                  color: Theme.of(context).extension<ExtraColors>()!.green,
                  onExplore: () {},
                ),
              ),
              Expanded(
                child: StatChip(
                  icon: Icons.cancel_rounded,
                  label: context.l10n.resultWrong,
                  value: '${state.response!.result.wrongAnswers}',
                  color: Theme.of(context).extension<ExtraColors>()!.red,
                  onExplore: () {},
                ),
              ),
              Expanded(
                child: StatChip(
                  icon: Icons.help_outline_rounded,
                  label: context.l10n.resultUnanswered,
                  value: '${state.response!.result.skippedAnswers}',
                  color: Theme.of(context).extension<ExtraColors>()!.yellow,
                  onExplore: () {},
                ),
              ),
            ],
          ),

          // /// Time taken
          TimeTakenCard(
            timeTaken: Duration(seconds: state.response!.result.durationSeconds),
            fullTime: Duration(seconds: state.response!.result.durationSeconds * 2),
          ),
          CategoryPerformanceWidget(),
          SizedBox(height: SpacesResources.s4),

          /// Previous results
          PreviousResultsListCardWidget(results: state.response!.previousResults ?? []),
          SizedBox(height: SpacesResources.s4),

          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
            ),
            onPressed: () {
              // Navigate to fetch custom questions with the result data
              context.pushReplacement(
                AppRoutes.fetchCustomQuestions.path,
                extra: FetchCustomQuestionsArguments(result: state.response!.result),
              );
            },
            child: Text(context.l10n.buttonsRetryTest, style: AppTextStyles.button),
          ),
          if (state.response?.result.lessonId != null) SizedBox(height: SpacesResources.s2),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
            ),
            onPressed: () {
              // Navigate to fetch custom questions with the result data
              context.pushReplacement(
                AppRoutes.fetchCustomQuestions.path,
                extra: FetchCustomQuestionsArguments(result: state.response!.result),
              );
            },
            child: Text(context.l10n.buttonsSmartRetryTest, style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }
}

class _ExploreResultLeaderboardView extends StatelessWidget {
  const _ExploreResultLeaderboardView({super.key, required this.state});
  final ExploreResultState state;

  @override
  Widget build(BuildContext context) {
    final leaderboard = state.leaderboardList ?? [];

    if (leaderboard.isEmpty) {
      return Center(child: Text('لا توجد بيانات للوحة المتصدرين'));
    }

    final String? currentUserId = Supabase.instance.client.auth.currentUser?.id;

    // Sort descending by score
    final sorted = [...leaderboard]..sort((a, b) => b.score.compareTo(a.score));

    return Padding(
      padding: PaddingResources.listViewPadding,
      child: ListView.separated(
        itemCount: sorted.length,
        separatorBuilder: (context, index) => const SizedBox(height: SpacesResources.s2),
        itemBuilder: (context, index) {
          final result = sorted[index];
          final rank = index + 1;
          final isCurrentUser = currentUserId != null && currentUserId == result.userId;

          return LeaderboardItemCardWidget(
            result: result,
            rank: rank,
            isCurrentUser: isCurrentUser,
            onTap: () {
              context.push(
                AppRoutes.exploreResult.path,
                extra: ExploreResultViewArguments(resultId: result.id),
              );
            },
          );
        },
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
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.resultTitle), leading: CloseIconWidget()),
      body: ErrorStateBodyWidget(
        title: 'فشل في الحصول على النتيجة',
        failure: state.failure!,
        onRetry: onRetry,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
