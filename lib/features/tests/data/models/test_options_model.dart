import 'package:bac_project/features/tests/domain/entities/test_options.dart';

class TestOptionsModel extends TestOptions {
  const TestOptionsModel({
    //
    required super.selectedMode,
    //
    required super.selectedCategories,
    required super.selectedQuestionsCount,
    required super.selectedUnitsIDs,
    required super.selectedLessonsIDs,
    //
    required super.categories,
    //
    required super.enableSounds,
    required super.showTrueAnswers,
  });

  factory TestOptionsModel.fromJson(Map<String, dynamic> json) {
    return TestOptionsModel(
      selectedMode: json['selected_mode'],
      selectedCategories: json['selected_categories'],
      selectedQuestionsCount: json['selected_questions_count'],
      selectedUnitsIDs: json['selected_units_ids'],
      selectedLessonsIDs: json['selected_lessons_ids'],
      categories: json['categories'],
      enableSounds: json['enable_sounds'],
      showTrueAnswers: json['show_true_answers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selected_mode': selectedMode,
      'selected_categories': selectedCategories,
      'selected_questions_count': selectedQuestionsCount,
      'selected_units_ids': selectedUnitsIDs,
      'selected_lessons_ids': selectedLessonsIDs,
      'categories': categories,
      'enable_sounds': enableSounds,
      'show_true_answers': showTrueAnswers,
    };
  }
}
