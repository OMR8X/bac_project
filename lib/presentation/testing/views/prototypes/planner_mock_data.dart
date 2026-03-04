import 'package:flutter/material.dart';

/// Mock lesson for the planner prototypes
class MockPlannerLesson {
  final String title;
  final String subject;
  final Color subjectColor;
  bool isCompleted;

  MockPlannerLesson({
    required this.title,
    required this.subject,
    required this.subjectColor,
    this.isCompleted = false,
  });
}

/// Mock data provider for all 5 prototype variations
class PlannerMockData {
  static List<MockPlannerLesson> createTodayLessons() => [
    MockPlannerLesson(
      title: 'الاشتقاق',
      subject: 'التحليل',
      subjectColor: const Color(0xFF2196F3),
      isCompleted: true,
    ),
    MockPlannerLesson(
      title: 'المتتاليات',
      subject: 'التحليل',
      subjectColor: const Color(0xFF2196F3),
      isCompleted: true,
    ),
    MockPlannerLesson(
      title: 'الدرس الأول — القوى',
      subject: 'الفيزياء',
      subjectColor: const Color(0xFF9C27B0),
    ),
    MockPlannerLesson(
      title: 'الدرس الثالث — التفاعلات',
      subject: 'الكيمياء',
      subjectColor: const Color(0xFF4CAF50),
    ),
    MockPlannerLesson(
      title: 'الدرس الخامس — النصوص',
      subject: 'العربي',
      subjectColor: const Color(0xFF00BCD4),
    ),
  ];

  static const int streakDays = 12;
  static const double overallProgress = 0.34;
  static const String dailyQuote = 'كل درس بتخلصه بيقربك من حلمك';
  static const String quoteAuthor = 'مجهول';

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير!';
    if (hour < 17) return 'مساء الخير!';
    return 'مساء الخير!';
  }

  static int completedCount(List<MockPlannerLesson> lessons) =>
      lessons.where((l) => l.isCompleted).length;
}
