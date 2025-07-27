import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final String unitId;

  const LessonsViewArguments({required this.unitId});
}

class TestModeSettingsArguments {
  final List<String>? unitIds ;
  final List<String>? lessonIds;

  const TestModeSettingsArguments({this.unitIds, this.lessonIds});
}
