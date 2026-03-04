import 'package:flutter/material.dart';
import '../../../../core/resources/styles/colors_resources.dart';
import '../../domain/entities/mock_study_data.dart';

class PlannerPickLessonView extends StatelessWidget {
  final PlannerSubject subject;

  const PlannerPickLessonView({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(subject.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: subject.lessons.length,
        itemBuilder: (context, index) {
          final lesson = subject.lessons[index];
          final isAlreadyAdded = MockStudyData.currentTodos.contains(lesson);

          return Card(
            elevation: 0,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Theme.of(context).dividerColor),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              title: Text(
                lesson.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              trailing:
                  isAlreadyAdded
                      ? const Icon(Icons.check_circle, color: ColorsResourcesLight.success)
                      : Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              onTap:
                  isAlreadyAdded
                      ? null
                      : () {
                        MockStudyData.currentTodos.add(lesson);
                        // Pop back to Dashboard (pop this view, then pop the Add view)
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
            ),
          );
        },
      ),
    );
  }
}
