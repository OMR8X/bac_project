import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/assets_resources.dart';
// sizes_resources not used in this file
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:bac_project/presentation/settings/widgets/switch_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/router/app_arguments.dart';
import '../../../core/widgets/ui/fields/bottom_buttons_widget.dart';
import '../../../core/widgets/ui/loading_widget.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/injector/app_injection.dart';

import '../../../features/tests/domain/entities/test_mode.dart';
import '../blocs/test_mode_settings_bloc.dart';
import '../widget/mode_card_widget.dart';

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
                  testOptions: TestOptions(
                    selectedUnitsIDs: arguments?.unitIds,
                    selectedTestsIDs: arguments?.lessonIds,
                    selectedMode: TestMode.testing,
                  ),
                ),
              ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.testPropertiesTitle),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.close),
          ),
          actions: [SwitchThemeWidget()],
        ),
        body: BlocConsumer<TestModeSettingsBloc, TestModeSettingsState>(
          listener: (BuildContext context, TestModeSettingsState state) {
            if (state.status == TestModeSettingsStatus.saved) {
              context.pushReplacementNamed(
                AppRoutes.quizzing.name,
                extra: TestingArguments(
                  questions: state.questions,
                  timeLimit: null,
                  testMode: state.testOptions.selectedMode,
                  lessonIds: state.testOptions.selectedTestsIDs,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == TestModeSettingsStatus.loading) {
              return const _LoadingView();
            } else if ([
              TestModeSettingsStatus.loaded,
              TestModeSettingsStatus.fetchingQuestions,
            ].contains(state.status)) {
              return _LoadedView(state: state);
            } else if (state.status == TestModeSettingsStatus.error) {
              return _ErrorView(message: state.message ?? 'An error occurred');
            }
            return const SizedBox.shrink();
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
                TestModeSettingsLoadEvent(testOptions: state.testOptions),
              );
            },
            child: Text(context.l10n.buttonsRetry),
          ),
        ],
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.state});

  final TestModeSettingsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SpacesResources.s4),
                StaggeredItemWrapperWidget(
                  position: 1,
                  child: ModeCardWidget(
                    isSelected: state.testOptions.selectedMode == TestMode.testing,
                    onTap:
                        () => context.read<TestModeSettingsBloc>().add(
                          TestModeSettingsUpdateModeEvent(selectedMode: TestMode.testing),
                        ),
                    title: context.l10n.testPropertiesModesTestModeTitle,
                    subtitle: context.l10n.testPropertiesModesTestModeSubtitle,
                    description: context.l10n.testPropertiesModesTestModeDescription,
                    imagePath: ImagesResources.chooseIcon,
                    imageColor: Theme.of(
                      context,
                    ).extension<ExtraColors>()!.blue.darker(0.1).withAlpha(200),
                  ),
                ),
                const SizedBox(height: SpacesResources.s2),
                StaggeredItemWrapperWidget(
                  position: 2,
                  child: ModeCardWidget(
                    isSelected: state.testOptions.selectedMode == TestMode.exploring,
                    onTap:
                        () => context.read<TestModeSettingsBloc>().add(
                          TestModeSettingsUpdateModeEvent(selectedMode: TestMode.exploring),
                        ),
                    title: context.l10n.testPropertiesModesExploreModeTitle,
                    subtitle: context.l10n.testPropertiesModesExploreModeSubtitle,
                    description: context.l10n.testPropertiesModesExploreModeDescription,
                    imagePath: ImagesResources.compassIcon,
                    imageColor: Theme.of(
                      context,
                    ).extension<ExtraColors>()!.green.darker(0.1).withAlpha(200),
                  ),
                ),
                // const SizedBox(height: SpacesResources.s2),
                // StaggeredItemWrapperWidget(
                //   position: 3,
                //   child: ModeCardWidget(
                //     isSelected: state.selectedMode == TestMode.custom,
                //     onTap: () => context.read<TestModeSettingsBloc>().add(
                //       TestModeSettingsUpdateModeEvent(selectedMode: TestMode.custom),
                //     ),
                //     titleKey: LocalizationKeys.testProperties.modes.customMode.title,
                //     subtitleKey: LocalizationKeys.testProperties.modes.customMode.subtitle,
                //     descriptionKey: LocalizationKeys.testProperties.modes.customMode.description,
                //     imagePath: ImagesResources.creativityIcon,
                //     imageColor: Theme.of(
                //       context,
                //     ).extension<ExtraColors>()!.pink.darker(0.1).withAlpha(200),
                //   ),
                // ),
                const SizedBox(height: SpacesResources.s24),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomButtonWidget(
                isLoading: state.status == TestModeSettingsStatus.fetchingQuestions,
                onPressed: () {
                  context.read<TestModeSettingsBloc>().add(const TestModeSettingsSubmitEvent());
                  // Navigate to testing view after saving settings
                },
                text: context.l10n.buttonsNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
