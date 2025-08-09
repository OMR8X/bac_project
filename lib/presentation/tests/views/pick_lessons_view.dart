import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/bottom_buttons_widget.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/core/widgets/ui/lesson_card_widget.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/presentation/tests/blocs/pick_lessons_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class PickLessonsView extends StatefulWidget {
  final PickLessonsArguments arguments;

  const PickLessonsView({super.key, required this.arguments});

  @override
  State<PickLessonsView> createState() => _PickLessonsViewState();
}

class _PickLessonsViewState extends State<PickLessonsView> {
  @override
  void initState() {
    super.initState();
    context.read<PickLessonsBloc>().add(
      PickLessonsInitializeEvent(unitId: widget.arguments.unitId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sl<LocalizationManager>().get(LocalizationKeys.pickLessons.title)),
      ),
      body: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: BlocBuilder<PickLessonsBloc, PickLessonsState>(
          builder: (context, state) {
            if (state.status == PickLessonsStatus.loading) {
              return const Center(child: LoadingWidget());
            } else if (state.status == PickLessonsStatus.error) {
              return Center(child: Text('Error: ${state.failure?.message}'));
            } else if (state.status == PickLessonsStatus.loaded) {
              return Stack(
                children: [
                  AnimationLimiter(
                    child: ListView.builder(
                      itemCount: state.allLessons.length,
                      padding: PaddingResources.listViewPadding,
                      itemBuilder: (context, index) {
                        final lesson = state.allLessons[index];
                        final isSelected = state.pickedLessonsId.contains(lesson.id);
                        return StaggeredItemWrapperWidget(
                          position: index,
                          child: LessonCardWidget(
                            title: lesson.title,
                            questionsCount: lesson.questionsCount,
                            icon: Icons.book,
                            isSelected: isSelected,
                            onTap: () {
                              if (isSelected) {
                                context.read<PickLessonsBloc>().add(
                                  UnselectLessonEvent(lesson: lesson),
                                );
                              } else {
                                context.read<PickLessonsBloc>().add(
                                  SelectLessonEvent(lesson: lesson),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomButtonWidget(
                      isEnabled: state.pickedLessonsId.isNotEmpty,
                      onPressed: () {
                        context.pushReplacement(
                          AppRoutes.testModeSettings.path,
                          extra: TestModeSettingsArguments(lessonIds: state.pickedLessonsId),
                        );
                      },
                      text: sl<LocalizationManager>().get(LocalizationKeys.buttons.pick),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink(); // Initial state or unexpected state
          },
        ),
      ),
    );
  }
}
