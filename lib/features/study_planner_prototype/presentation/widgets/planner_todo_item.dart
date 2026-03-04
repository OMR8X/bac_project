import 'package:flutter/material.dart';
import '../../../../core/resources/styles/colors_resources.dart';
import '../../domain/entities/mock_study_data.dart';

class PlannerTodoItem extends StatelessWidget {
  final PlannerLesson lesson;
  final VoidCallback onToggle;

  const PlannerTodoItem({
    super.key,
    required this.lesson,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Find the subject for this lesson to get the color
    final subject = MockStudyData.subjects.firstWhere(
      (s) => s.lessons.contains(lesson),
      orElse: () => MockStudyData.subjects.first,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: subject.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: lesson.isCompleted ? TextDecoration.lineThrough : null,
                    color:
                        lesson.isCompleted
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  subject.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lesson.isCompleted ? ColorsResourcesLight.success : Colors.transparent,
                border: Border.all(
                  color: lesson.isCompleted ? ColorsResourcesLight.success : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child:
                  lesson.isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
