// 'equatable' not required here
import 'package:flutter/material.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/requests/add_result_request.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';

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

class QuizzingArguments {
  final List<Question>? questions;
  final int? timeLimit;
  final TestMode? testMode;
  final List<int>? lessonIds;

  const QuizzingArguments({this.questions, this.timeLimit, this.testMode, this.lessonIds});
}

class SearchViewArguments {
  final int? unitId;
  final String? heroTag;

  const SearchViewArguments({this.unitId, this.heroTag});
}

class ExploreResultViewArguments {
  final int resultId;

  const ExploreResultViewArguments({required this.resultId});
}

class FetchCustomQuestionsArguments {
  final int? resultId;
  final List<int>? questionIds;

  const FetchCustomQuestionsArguments({this.resultId, this.questionIds});
}

class MotivationalQuoteArguments {
  final MotivationalQuote quote;

  const MotivationalQuoteArguments({required this.quote});
}
