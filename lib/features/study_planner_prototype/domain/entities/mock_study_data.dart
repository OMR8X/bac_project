import 'package:flutter/material.dart';
import '../../../../features/subjects/domain/entities/subject.dart';
import '../../../../features/subjects/domain/entities/subject_lessson.dart';

// Import all subject data
import '../../../../features/subjects/data/analysis/subject.dart';
import '../../../../features/subjects/data/analysis/lessons.dart';
import '../../../../features/subjects/data/arabic/subject.dart';
import '../../../../features/subjects/data/arabic/lessons.dart';
import '../../../../features/subjects/data/chemistry/subject.dart';
import '../../../../features/subjects/data/chemistry/lessons.dart';
import '../../../../features/subjects/data/english/subject.dart';
import '../../../../features/subjects/data/english/lessons.dart';
// Note: french subject file has a typo in the repo 'materaill.dart'
import '../../../../features/subjects/data/french/materaill.dart';
import '../../../../features/subjects/data/french/lessons.dart';
import '../../../../features/subjects/data/geography/subject.dart';
import '../../../../features/subjects/data/geography/lessons.dart';
import '../../../../features/subjects/data/history/subject.dart';
import '../../../../features/subjects/data/history/lessons.dart';
import '../../../../features/subjects/data/patriotism/subject.dart';
import '../../../../features/subjects/data/patriotism/lessons.dart';
import '../../../../features/subjects/data/philosophy1/subject.dart';
import '../../../../features/subjects/data/philosophy1/lessons.dart';
import '../../../../features/subjects/data/philosophy2/subject.dart';
import '../../../../features/subjects/data/philosophy2/lessons.dart';
import '../../../../features/subjects/data/physics/subject.dart';
import '../../../../features/subjects/data/physics/lessons.dart';
import '../../../../features/subjects/data/rays/subject.dart';
import '../../../../features/subjects/data/rays/lessons.dart';
import '../../../../features/subjects/data/religion/subject.dart';
import '../../../../features/subjects/data/religion/lessons.dart';
import '../../../../features/subjects/data/sciences/subject.dart';
import '../../../../features/subjects/data/sciences/lessons.dart';

/// Wrapper for SubjectLesson to be used in the Planner
class PlannerLesson {
  final SubjectLesson _lesson;

  PlannerLesson(this._lesson);

  String get title => _lesson.title;

  // Map 'done' to 'isCompleted'
  bool get isCompleted => _lesson.done;
  set isCompleted(bool value) => _lesson.done = value;

  // For equality checks
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlannerLesson && runtimeType == other.runtimeType && _lesson == other._lesson;

  @override
  int get hashCode => _lesson.hashCode;
}

/// Wrapper for Subject to match UI requirements and hold lessons
class PlannerSubject {
  final Subject _subject;
  final List<PlannerLesson> lessons;

  PlannerSubject(this._subject, List<SubjectLesson> subjectLessons)
    : lessons = subjectLessons.map((l) => PlannerLesson(l)).toList();

  String get name => _subject.name;
  Color get color => _subject.color;

  // Helper to count completed lessons
  int get completedLessons => lessons.where((l) => l.isCompleted).length;
}

class MockStudyData {
  // Static list of all subjects wrapping the real data
  static final List<PlannerSubject> subjects = [
    PlannerSubject(arabic, arabicSubjectLessons),
    PlannerSubject(analysis, analysisSubjectLessons), // Math 1
    // Note: raysSubjectLesson is singular in the data file
    PlannerSubject(rays, raysSubjectLesson), // Math 2 (Geometry/Rays)
    PlannerSubject(physics, physicsSubjectLessons),
    PlannerSubject(chemistry, chemistrySubjectLessons),
    PlannerSubject(sciences, sciencesSubjectLessons),
    PlannerSubject(english, englishSubjectLessons),
    PlannerSubject(french, frenchSubjectLessons),
    PlannerSubject(history, historySubjectLessons),
    // Note: gerographySubjectLessons has a typo in the data file
    PlannerSubject(geography, gerographySubjectLessons),
    PlannerSubject(patriotism, patriotismSubjectLessons),
    PlannerSubject(religion, religionSubjectLessons),
    PlannerSubject(philosophy1, philosophy1SubjectLessons),
    PlannerSubject(philosophy2, philosophy2SubjectLessons),
  ];

  // Global To-Do list for the prototype ("Today's Plan")
  // We can filter this from all lessons or just keep a separate list of added lessons.
  // For the prototype flow (Add -> Pick), a separate list is easier.
  static final List<PlannerLesson> currentTodos = [];
}
