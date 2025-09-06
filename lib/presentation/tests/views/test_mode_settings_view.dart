import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
// sizes_resources not used in this file
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/mode_switcher_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/questions_categories_picker_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/questions_count_picker_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/switch_tile_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/router/app_arguments.dart';
import '../../../core/widgets/ui/fields/bottom_buttons_widget.dart';
import '../../../core/widgets/ui/loading_widget.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/injector/app_injection.dart';

import '../blocs/test_mode_settings/test_mode_settings_bloc.dart';

class TestModeSettingsView extends StatelessWidget {
  const TestModeSettingsView({super.key, this.arguments});

  final TestModeSettingsArguments? arguments;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<TestModeSettingsBloc>()..add(
                TestModeSettingsLoadEvent(
                  unitIds: arguments?.unitIds,
                  lessonIds: arguments?.lessonIds,
                ),
              ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.testPropertiesTitle),
          centerTitle: true,
          leading: CloseIconWidget(),
          actions: [
            AppBarIconWidget(
              icon: ImageIcon(AssetImage(UIImagesResources.questionMarkIcon)),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocConsumer<TestModeSettingsBloc, TestModeSettingsState>(
          buildWhen: (previous, current) {
            if (current.status == TestModeSettingsStatus.fetchingQuestions) {
              return false;
            }
            return previous.status != current.status;
          },
          listener: (BuildContext context, TestModeSettingsState state) {
            if (state.status == TestModeSettingsStatus.saved) {
              context.pushReplacementNamed(
                AppRoutes.quizzing.name,
                extra: QuizzingArguments(
                  questions: state.questions,
                  timeLimit: null,
                  testMode: state.testOptions.selectedMode,
                  lessonIds: state.testOptions.selectedLessonsIDs,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == TestModeSettingsStatus.loaded ||
                state.status == TestModeSettingsStatus.fetchingQuestions) {
              return _LoadedView(key: ValueKey(state.testOptions.selectedMode), state: state);
            }
            if (state.status == TestModeSettingsStatus.error) {
              return _ErrorView(message: state.message ?? 'An error occurred');
            }
            return const _LoadingView();
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const LoadingWidget();
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
          SizedBox(height: SpacesResources.s15),
          Text(message, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
          SizedBox(height: SpacesResources.s15),
          ElevatedButton(
            onPressed: () {
              final state = context.read<TestModeSettingsBloc>().state;
              context.read<TestModeSettingsBloc>().add(
                TestModeSettingsLoadEvent(
                  unitIds: state.testOptions.selectedUnitsIDs,
                  lessonIds: state.testOptions.selectedLessonsIDs,
                ),
              );
            },
            child: Text(context.l10n.buttonsRetryTest),
          ),
        ],
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({super.key, required this.state});

  final TestModeSettingsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: PaddingResources.listViewPadding,
              child: Column(
                spacing: SpacesResources.s2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Mode Switcher
                  StaggeredItemWrapperWidget(
                    position: 0,
                    child: ModeSwitcherWidget(
                      firstOption: SwitchOption(
                        value: TestMode.exploring,
                        label: context.l10n.exploreMode,
                        icon: Icons.explore,
                      ),
                      secondOption: SwitchOption(
                        value: TestMode.testing,
                        label: context.l10n.testMode,
                        icon: Icons.science,
                      ),
                      currentValue: state.testOptions.selectedMode,
                      onChanged: (mode) {
                        context.read<TestModeSettingsBloc>().add(
                          TestModeSettingsUpdateModeEvent(selectedMode: mode),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                    buildWhen: (previous, current) {
                      return previous.testOptions.selectedMode != current.testOptions.selectedMode;
                    },
                    builder: (context, state) {
                      if (state.testOptions.selectedMode == TestMode.testing) {
                        return StaggeredItemWrapperWidget(
                          key: ValueKey(state.testOptions.selectedMode),
                          position: 1,
                          child: Card(
                            child: ListTile(
                              contentPadding: PaddingResources.cardSmallInnerPadding,
                              title: Text(
                                context.l10n.testModeDetailsTitle,
                                // style: AppTextStyles.cardMediumTitle.copyWith(height: 2.5),
                              ),
                              subtitle: Text(
                                context.l10n.testModeDetailsContent,
                                // style: AppTextStyles.cardMediumSubtitle,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  /// Question Categories Picker
                  BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                    buildWhen: (previous, current) {
                      if (current.status == TestModeSettingsStatus.fetchingQuestions) {
                        return false;
                      }
                      if (previous.testOptions.selectedMode != current.testOptions.selectedMode) {
                        return true;
                      }
                      return previous.testOptions.selectedCategories !=
                          current.testOptions.selectedCategories;
                    },
                    builder: (context, state) {
                      if (state.testOptions.selectedMode != TestMode.exploring) {
                        return const SizedBox.shrink();
                      }
                      return StaggeredItemWrapperWidget(
                        key: ValueKey(state.testOptions.selectedMode),
                        position: 1,
                        child: QuestionCategoriesPickerWidget<QuestionCategory>(
                          categories: state.testOptions.categories ?? [],
                          selected: state.testOptions.selectedCategories ?? [],
                          onChanged: (value) {
                            context.read<TestModeSettingsBloc>().add(
                              TestModeSettingsUpdateCategoriesEvent(categories: value),
                            );
                          },
                          label: (category) => "${category.name} (${category.questionsCount})",
                        ),
                      );
                    },
                  ),

                  /// Question Count Picker
                  BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                    buildWhen: (previous, current) {
                      if (current.status == TestModeSettingsStatus.fetchingQuestions) {
                        return false;
                      }
                      if (previous.testOptions.selectedMode != current.testOptions.selectedMode) {
                        return true;
                      }
                      final cond1 =
                          previous.testOptions.selectedQuestionsCount !=
                          current.testOptions.selectedQuestionsCount;
                      final cond2 =
                          previous.testOptions.selectedCategories !=
                          current.testOptions.selectedCategories;
                      return cond1 || cond2;
                    },
                    builder: (context, state) {
                      if (state.testOptions.selectedMode != TestMode.exploring) {
                        return const SizedBox.shrink();
                      }
                      if (state.testOptions.selectedCategories?.isEmpty ?? true) {
                        return const SizedBox.shrink();
                      }
                      return StaggeredItemWrapperWidget(
                        key: ValueKey(state.testOptions.selectedMode),
                        position: 2,
                        child: QuestionCountPickerWidget(
                          options: state.testOptions.countOptions(),
                          initialCount: state.testOptions.selectedQuestionsCount,
                          onChanged: (value) {
                            context.read<TestModeSettingsBloc>().add(
                              TestModeSettingsUpdateQuestionsCountEvent(questionsCount: value),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  ///Switchers
                  BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                    buildWhen: (previous, current) {
                      if (current.status == TestModeSettingsStatus.fetchingQuestions) {
                        return false;
                      }
                      if (previous.testOptions.selectedMode != current.testOptions.selectedMode) {
                        return true;
                      }
                      if (previous.testOptions.enableSounds != current.testOptions.enableSounds) {
                        return true;
                      }
                      if (previous.testOptions.showTrueAnswers !=
                          current.testOptions.showTrueAnswers) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return StaggeredItemWrapperWidget(
                        key: ValueKey(state.testOptions.selectedMode),
                        position: 3,
                        child: Card(
                          child: Column(
                            children: [
                              if (state.testOptions.selectedMode == TestMode.exploring)
                                SwitchTileWidget(
                                  title: context.l10n.showTrueAnswerTitle,
                                  subtitle: context.l10n.showTrueAnswerSubtitle,
                                  enabled: state.testOptions.showTrueAnswers,
                                  onChanged: (value) {
                                    context.read<TestModeSettingsBloc>().add(
                                      TestModeSettingsUpdateShowTrueAnswersEvent(
                                        showTrueAnswers: value,
                                      ),
                                    );
                                  },
                                ),
                              SwitchTileWidget(
                                title: context.l10n.enableSoundEffectsTitle,
                                subtitle: context.l10n.enableSoundEffectsSubtitle,
                                enabled: state.testOptions.enableSounds,
                                onChanged: (value) {
                                  context.read<TestModeSettingsBloc>().add(
                                    TestModeSettingsUpdateEnableSoundsEvent(enableSounds: value),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                buildWhen: (previous, current) {
                  if (previous.testOptions.selectedMode != current.testOptions.selectedMode) {
                    return true;
                  }
                  if (previous.testOptions.selectedCategories !=
                      current.testOptions.selectedCategories) {
                    return true;
                  }
                  if (previous.status != current.status) {
                    return true;
                  }

                  return previous.testOptions.selectedQuestionsCount !=
                      current.testOptions.selectedQuestionsCount;
                },
                builder: (context, state) {
                  bool isEnabled = state.testOptions.selectedQuestionsCount != null;
                  if (state.testOptions.selectedMode == TestMode.testing) {
                    isEnabled = true;
                  } else if (state.testOptions.selectedCategories?.isEmpty ?? true) {
                    isEnabled = false;
                  }
                  return BottomButtonWidget(
                    isLoading: state.status == TestModeSettingsStatus.fetchingQuestions,
                    isEnabled: isEnabled,
                    onPressed: () {
                      context.read<TestModeSettingsBloc>().add(const TestModeSettingsSubmitEvent());
                      // Navigate to testing view after saving settings
                    },
                    text: context.l10n.buttonsStartTest,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
