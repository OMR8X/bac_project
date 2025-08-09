// 'equatable' not required here
import 'package:flutter/material.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

class ExploreManagerViewArguments {
  final String title;
  final List<dynamic> items;
  final String Function(dynamic t) itemName;
  final String Function(dynamic t) itemDetails;
  final void Function(int index) onDelete;
  final void Function(int index) onEdit;
  final VoidCallback onCreate;

  const ExploreManagerViewArguments({
    required this.title,
    required this.items,
    required this.itemName,
    required this.itemDetails,
    required this.onDelete,
    required this.onEdit,
    required this.onCreate,
  });
}

class LessonsViewArguments {
  final int unitId;

  const LessonsViewArguments({required this.unitId});
}

class PickLessonsArguments {
  final int unitId;

  const PickLessonsArguments({required this.unitId});
}

class TestModeSettingsArguments {
  final List<int>? unitIds;
  final List<int>? lessonIds;

  const TestModeSettingsArguments({this.unitIds, this.lessonIds});
}

class TestingArguments {
  final List<Question>? questions;
  final int? timeLimit;
  final TestMode? testMode;
  final List<int>? lessonIds;

  const TestingArguments({this.questions, this.timeLimit, this.testMode, this.lessonIds});
}

class SearchViewArguments {
  final int? unitId;
  final String? heroTag;

  const SearchViewArguments({this.unitId, this.heroTag});
}
