import 'package:neuro_app/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:neuro_app/presentation/lessons/widgets/lesson_card_widget.dart';
import 'package:neuro_app/features/tests/domain/entities/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/router/app_arguments.dart';
import '../../../core/services/router/routes.dart';
// api المحلي

class LessonsCardsBuilderWidget extends StatelessWidget {
  final List<Lesson> lessons;

  const LessonsCardsBuilderWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text('لا توجد بيانات')),
      );
    }
    return AnimationLimiter(
      child: SliverList.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return StaggeredItemWrapperWidget(
            position: index,
            key: ValueKey(lesson.id),
            child: Column(
              children: [
                LessonCardWidget(
                  icon: Icons.school,
                  title: lesson.title,
                  // label: lesson.questionsCount,
                  onTap: () {
                    context.pushReplacement(
                      Routes.testModeSettings.path,
                      extra: TestModeSettingsArguments(
                        unitIds: [lesson.unitId],
                        lessonIds: [lesson.id],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
