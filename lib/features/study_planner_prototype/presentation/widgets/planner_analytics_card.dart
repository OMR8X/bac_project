import 'package:flutter/material.dart';
import '../../../../core/resources/styles/colors_resources.dart';
import '../../domain/entities/mock_study_data.dart';

class PlannerAnalyticsCard extends StatelessWidget {
  const PlannerAnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate overall progress
    int totalLessons = 0;
    int completedLessons = 0;

    for (var subject in MockStudyData.subjects) {
      totalLessons += subject.lessons.length;
      completedLessons += subject.completedLessons;
    }

    final double progress = totalLessons == 0 ? 0 : completedLessons / totalLessons;
    final int percentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, // Using primary color for impact
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'التقدم العام',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedLessons / $totalLessons درس',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorsResourcesLight.success),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
