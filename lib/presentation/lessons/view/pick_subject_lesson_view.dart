import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';
import '../../../../features/subjects/domain/entities/subject.dart';
import '../../../../features/tests/domain/entities/lesson.dart';
import '../widgets/lesson_card_widget.dart';

class PickSubjectLessonView extends StatelessWidget {
  const PickSubjectLessonView({
    super.key,
    required this.subject,
    required this.lessons,
    required this.onPickLesson,
  });

  final Subject subject;
  final List<Lesson> lessons;
  final void Function(Lesson) onPickLesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.pickLessonTitle(subject.name)),
      ),
      body: ListView.builder(
        padding: Paddings.screenBodyPadding,
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return LessonCardWidget(
            title: lesson.title,
            // label: lesson.questionsCount,
            onTap: () => onPickLesson(lesson),
            icon: Icons.school,
          );
        },
      ),
    );
  }
}
