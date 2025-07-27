import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/router/app_arguments.dart';
import '../../../core/widgets/ui/fields/mode_switcher_widget.dart';
import '../../../core/widgets/ui/loading_widget.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/services/localization/localization_keys.dart';
import '../../../core/services/localization/localization_manager.dart';
import '../../../features/tests/domain/entities/test_options.dart';
import '../blocs/test_mode_settings_bloc.dart';
import '../widget/mode_items_builder.dart';

class TestModeSettingsView extends StatelessWidget {
  const TestModeSettingsView({super.key, this.arguments, required this.onSave});

  final TestModeSettingsArguments? arguments;
  final Function(TestOptions updatedOptions) onSave;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              TestModeSettingsBloc()..add(
                TestModeSettingsLoadEvent(
                  unitIds: arguments?.unitIds,
                  lessonIds: arguments?.lessonIds,
                ),
              ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(sl<LocalizationManager>().get(LocalizationKeys.testProperties.title)),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<TestModeSettingsBloc, TestModeSettingsState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          listener: (context, state) {
            if (state.isSaved && state.savedOptions != null) {
              onSave(state.savedOptions!);
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const _LoadingView();
            } else if (state.isLoaded) {
              return _LoadedView(state: state);
            } else if (state.isError) {
              return _ErrorView(message: state.errorMessage ?? 'An error occurred');
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
              context.read<TestModeSettingsBloc>().add(const TestModeSettingsLoadEvent());
            },
            child: Text(sl<LocalizationManager>().get(LocalizationKeys.buttons.retry)),
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
    // Ensure we have the required data for loaded state
    if (state.testOptions == null || state.selectedMode == null) {
      return const SizedBox.shrink();
    }
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ///
                ModeSwitcherWidget(
                  initialIsExploreMode: state.selectedMode == TestMode.exploring,
                  onModeChanged: (isExploreMode) {
                    final newMode = isExploreMode ? TestMode.exploring : TestMode.testing;
                    context.read<TestModeSettingsBloc>().add(
                      TestModeSettingsUpdateModeEvent(selectedMode: newMode),
                    );
                  },
                ),

                ///
                _ModeItemsSection(
                  modeSettings: state.testOptions!.getSettingsForMode(state.selectedMode!),
                  testMode: state.selectedMode!,
                  selectedCategories: state.selectedCategories,
                  showCorrectAnswer: state.showCorrectAnswer,
                  soundEffectsEnabled: state.soundEffectsEnabled,
                ),
              ],
            ),
          ),
          _SaveButtonSection(),
        ],
      ),
    );
  }
}

class _ModeItemsSection extends StatelessWidget {
  const _ModeItemsSection({
    required this.modeSettings,
    required this.testMode,
    required this.selectedCategories,
    required this.showCorrectAnswer,
    required this.soundEffectsEnabled,
  });

  final ModeSettings? modeSettings;
  final TestMode testMode;
  final List<QuestionCategory> selectedCategories;
  final bool showCorrectAnswer;
  final bool soundEffectsEnabled;

  @override
  Widget build(BuildContext context) {
    if (modeSettings == null) return const SizedBox.shrink();
    return ModeItemsWidget(
      modeSettings: modeSettings!,
      testMode: testMode,
      onCategoriesChanged: (categories) {
        context.read<TestModeSettingsBloc>().add(
          TestModeSettingsUpdateCategoriesEvent(selectedCategories: categories),
        );
      },
      onShowCorrectAnswerChanged: (enabled) {
        context.read<TestModeSettingsBloc>().add(
          TestModeSettingsToggleShowCorrectAnswerEvent(showCorrectAnswer: enabled),
        );
      },
      onSoundEffectsChanged: (enabled) {
        context.read<TestModeSettingsBloc>().add(
          TestModeSettingsToggleSoundEffectsEvent(soundEffectsEnabled: enabled),
        );
      },
    );
  }
}

class _SaveButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingResources.screenSidesPadding,
      child: FilledButton(
        onPressed: () {
          context.read<TestModeSettingsBloc>().add(const TestModeSettingsSaveEvent());
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        child: Text(sl<LocalizationManager>().get(LocalizationKeys.buttons.save)),
      ),
    );
  }
}
