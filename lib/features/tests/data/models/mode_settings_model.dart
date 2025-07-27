import 'package:bac_project/features/tests/data/mappers/lesson_mapper.dart';
import 'package:bac_project/features/tests/data/mappers/question_category_mapper.dart';
import 'package:bac_project/features/tests/data/models/lesson_model.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';

class ModeSettingsModel extends ModeSettings {
  const ModeSettingsModel({
    required super.canSelectCategories,
    required super.canSelectQuestionCount,
    required super.canToggleShowCorrectAnswer,
    required super.canToggleSoundEffects,
    required super.availableCategories,
    super.availableLessons,
  });

  factory ModeSettingsModel.fromJson(Map<String, dynamic> json) {
    return ModeSettingsModel(
      canSelectCategories: json['can_select_categories'] as bool,
      canSelectQuestionCount: json['can_select_question_count'] as bool,
      canToggleShowCorrectAnswer: json['can_toggle_show_correct_answer'] as bool,
      canToggleSoundEffects: json['can_toggle_sound_effects'] as bool,
      availableCategories:
          (json['available_categories'] as List<dynamic>)
              .map((e) => QuestionCategoryModel.fromJson(e))
              .toList(),
      availableLessons:
          (json['available_lessons'] as List<dynamic>?)
              ?.map((e) => LessonModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'can_select_categories': canSelectCategories,
      'can_select_question_count': canSelectQuestionCount,
      'can_toggle_show_correct_answer': canToggleShowCorrectAnswer,
      'can_toggle_sound_effects': canToggleSoundEffects,
      'available_categories': availableCategories.map((e) => e.toModel().toJson()).toList(),
      'available_lessons': availableLessons?.map((e) => e.toModel().toJson()).toList(),
    };
  }

  @override
  ModeSettingsModel copyWith({
    bool? canSelectCategories,
    bool? canSelectQuestionCount,
    bool? canToggleShowCorrectAnswer,
    bool? canToggleSoundEffects,
    List<QuestionCategory>? availableCategories,
    List<Lesson>? availableLessons,
  }) {
    return ModeSettingsModel(
      canSelectCategories: canSelectCategories ?? this.canSelectCategories,
      canSelectQuestionCount: canSelectQuestionCount ?? this.canSelectQuestionCount,
      canToggleShowCorrectAnswer: canToggleShowCorrectAnswer ?? this.canToggleShowCorrectAnswer,
      canToggleSoundEffects: canToggleSoundEffects ?? this.canToggleSoundEffects,
      availableCategories: availableCategories ?? this.availableCategories,
      availableLessons: availableLessons ?? this.availableLessons,
    );
  }

  @override
  String toString() =>
      'ModeSettingsModel(canSelectCategories: $canSelectCategories, canSelectQuestionCount: $canSelectQuestionCount, canToggleShowCorrectAnswer: $canToggleShowCorrectAnswer, canToggleSoundEffects: $canToggleSoundEffects, availableCategories: $availableCategories, availableLessons: $availableLessons)';
}
