import 'package:bac_project/core/services/local/local_json_data_api.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/lesson_card_widget.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart'
    show CustomCardData;
import 'package:bac_project/presentation/home/models/custom_navigation_card_model.dart';
import 'package:bac_project/presentation/home/views/lessons_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/services/router/app_arguments.dart';
import '../../../core/services/router/app_routes.dart';
import '../../../core/widgets/ui/loading_widget.dart';
// api المحلي

class LessonsCardsBuilderWidget extends StatelessWidget {
  final List<Lesson> lessons;

  const LessonsCardsBuilderWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(child: Text('لا توجد بيانات'));
    }
    return StaggeredListWrapperWidget(
      position: 2,
      child: ListView.builder(
        padding: PaddingResources.listViewPadding,
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return StaggeredItemWrapperWidget(
            position: index,
            child: LessonCardWidget(
              icon: Icons.school,
              title: lesson.title,
              subtitle: lesson.questionsLength?.toString(),
              onTap: () {
                context.push(
                  AppRoutes.testModeSettings.path,
                  extra: TestModeSettingsArguments(
                    unitIds: [lesson.unitId],
                    lessonIds: [lesson.id],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
