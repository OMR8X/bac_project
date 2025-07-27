import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/presentation/tests/blocs/test_mode_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/widgets/ui/fields/questions_categories_picker_widget.dart';
import '../../../core/widgets/ui/fields/switch_tile_widget.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/services/localization/localization_keys.dart';
import '../../../core/services/localization/localization_manager.dart';
import '../../../features/tests/domain/entities/test_options.dart';

/// A reusable widget that builds UI based on ModeSettings configuration
/// and handles all mode-specific interactions
class ModeItemsWidget extends StatelessWidget {
  const ModeItemsWidget({
    super.key,
    required this.testMode,
    required this.modeSettings,
    this.onCategoriesChanged,
    this.onShowCorrectAnswerChanged,
    this.onSoundEffectsChanged,
  });

  final ModeSettings modeSettings;
  final TestMode testMode;

  final void Function(List<QuestionCategory> categories)? onCategoriesChanged;
  final void Function(bool enabled)? onShowCorrectAnswerChanged;
  final void Function(bool enabled)? onSoundEffectsChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
      buildWhen: (previous, current) {
        return previous.selectedMode != current.selectedMode;
      },
      builder: (context, state) {
        ///
        final modeSettings = state.testOptions?.getSettingsForMode(state.selectedMode!);

        ///
        if (modeSettings == null) return const SizedBox.shrink();

        ///
        return AnimationLimiter(
          key: ValueKey("mode-items-widget-${state.selectedMode}"),
          child: Column(
            children: [
              if (modeSettings.canSelectCategories)
                StaggeredItemWrapperWidget(
                  position: 1,
                  child: _CategoriesSectionWidget(onChanged: onCategoriesChanged),
                ),
              if (modeSettings.canToggleShowCorrectAnswer || modeSettings.canToggleSoundEffects)
                StaggeredItemWrapperWidget(
                  position: 2,
                  child: _SettingsTogglesSectionWidget(
                    canToggleShowCorrectAnswer: modeSettings.canToggleShowCorrectAnswer,
                    canToggleSoundEffects: modeSettings.canToggleSoundEffects,
                    showCorrectAnswer: state.showCorrectAnswer,
                    soundEffectsEnabled: state.soundEffectsEnabled,
                    onShowCorrectAnswerChanged: onShowCorrectAnswerChanged,
                    onSoundEffectsChanged: onSoundEffectsChanged,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoriesSectionWidget extends StatelessWidget {
  const _CategoriesSectionWidget({super.key, this.onChanged});

  final void Function(List<QuestionCategory> categories)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
      buildWhen: (previous, current) {
        return current.selectedCategories != previous.selectedCategories;
      },
      builder: (context, state) {
        final modeSettings = state.testOptions!.getSettingsForMode(state.selectedMode!)!;
        return QuestionCategoriesPickerWidget<QuestionCategory>(
          categories: modeSettings.availableCategories,
          selected: state.selectedCategories,
          label: (category) => category.name,
          onChanged: (value) {
            if (value.isEmpty) return;
            onChanged?.call(value);
          },
        );
      },
    );
  }
}

class _SettingsTogglesSectionWidget extends StatelessWidget {
  const _SettingsTogglesSectionWidget({
    super.key,
    required this.canToggleShowCorrectAnswer,
    required this.canToggleSoundEffects,
    required this.showCorrectAnswer,
    required this.soundEffectsEnabled,
    this.onShowCorrectAnswerChanged,
    this.onSoundEffectsChanged,
  });

  final bool canToggleShowCorrectAnswer;
  final bool canToggleSoundEffects;
  final bool showCorrectAnswer;
  final bool soundEffectsEnabled;
  final void Function(bool enabled)? onShowCorrectAnswerChanged;
  final void Function(bool enabled)? onSoundEffectsChanged;

  bool get hasToggles => canToggleShowCorrectAnswer || canToggleSoundEffects;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingResources.chipCardInnerPadding,
        child: Column(
          children: [
            if (canToggleShowCorrectAnswer)
              BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                buildWhen: (previous, current) {
                  return current.showCorrectAnswer != previous.showCorrectAnswer;
                },
                builder: (context, state) {
                  return SwitchTileWidget(
                    title: sl<LocalizationManager>().get(
                      LocalizationKeys.testProperties.answerVisibility.showTrueAnswerTitle,
                    ),
                    subtitle: sl<LocalizationManager>().get(
                      LocalizationKeys.testProperties.answerVisibility.showTrueAnswerSubtitle,
                    ),
                    enabled: state.showCorrectAnswer,
                    onChanged: onShowCorrectAnswerChanged ?? (_) {},
                  );
                },
              ),

            if (canToggleSoundEffects)
              BlocBuilder<TestModeSettingsBloc, TestModeSettingsState>(
                buildWhen: (previous, current) {
                  return current.soundEffectsEnabled != previous.soundEffectsEnabled;
                },
                builder: (context, state) {
                  return SwitchTileWidget(
                    title: sl<LocalizationManager>().get(
                      LocalizationKeys.testProperties.enableSoundEffects.title,
                    ),
                    subtitle: sl<LocalizationManager>().get(
                      LocalizationKeys.testProperties.enableSoundEffects.subtitle,
                    ),
                    enabled: state.soundEffectsEnabled,
                    onChanged: onSoundEffectsChanged ?? (_) {},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
