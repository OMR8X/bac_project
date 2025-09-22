import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

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
      selectedMode: TestMode.values.byName(json['selected_mode'] as String),
      selectedCategories:
          (json['selected_categories'] as List<dynamic>?)
              ?.map(
                (category) => QuestionCategory(
                  id: category['id'] as int,
                  title: category['title'] as String,
                  questionsCount: category['questions_count'] as int?,
                  isTypeable: category['is_typeable'] as bool,
                  isOrderable: category['is_orderable'] as bool,
                  isMCQ: category['is_mcq'] as bool,
                  isSingleAnswer: category['is_single_answer'] as bool,
                ),
              )
              .toList(),
      selectedQuestionsCount: json['selected_questions_count'] as int?,
      selectedUnitsIDs:
          (json['selected_units_ids'] as List<dynamic>?)?.map((id) => id as int).toList(),
      selectedLessonsIDs:
          (json['selected_lessons_ids'] as List<dynamic>?)?.map((id) => id as int).toList(),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map(
                (category) => QuestionCategory(
                  id: category['id'] as int,
                  title: category['title'] as String,
                  questionsCount: category['questions_count'] as int?,
                  isTypeable: category['is_typeable'] as bool,
                  isOrderable: category['is_orderable'] as bool,
                  isMCQ: category['is_mcq'] as bool,
                  isSingleAnswer: category['is_single_answer'] as bool,
                ),
              )
              .toList(),
      enableSounds: json['enable_sounds'] as bool,
      showTrueAnswers: json['show_true_answers'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selected_mode': selectedMode.name,
      'selected_categories':
          selectedCategories
              ?.map(
                (category) => {
                  'id': category.id,
                  'title': category.title,
                  'questions_count': category.questionsCount,
                  'is_typeable': category.isTypeable,
                  'is_orderable': category.isOrderable,
                  'is_mcq': category.isMCQ,
                  'is_single_answer': category.isSingleAnswer,
                },
              )
              .toList(),
      'selected_questions_count': selectedQuestionsCount,
      'selected_units_ids': selectedUnitsIDs,
      'selected_lessons_ids': selectedLessonsIDs,
      'categories':
          categories
              ?.map(
                (category) => {
                  'id': category.id,
                  'title': category.title,
                  'questions_count': category.questionsCount,
                },
              )
              .toList(),
      'enable_sounds': enableSounds,
      'show_true_answers': showTrueAnswers,
    };
  }
}
