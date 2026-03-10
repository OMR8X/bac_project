// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestOptionsModel _$TestOptionsModelFromJson(
  Map<String, dynamic> json,
) => TestOptionsModel(
  selectedQuestionsCount: (json['selected_questions_count'] as num?)?.toInt(),
  selectedUnitsIds:
      (json['selected_units_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
  selectedLessonsIds:
      (json['selected_lessons_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
  enableSounds: json['enable_sounds'] as bool,
  showTrueAnswers: json['show_true_answers'] as bool,
  selectedMode: TestOptionsModel._selectedModeFromJson(
    json['selected_mode'] as String,
  ),
  selectedCategories: TestOptionsModel._categoriesFromJson(
    json['selected_categories'] as List?,
  ),
  categories: TestOptionsModel._categoriesFromJson(json['categories'] as List?),
);

Map<String, dynamic> _$TestOptionsModelToJson(
  TestOptionsModel instance,
) => <String, dynamic>{
  'show_true_answers': instance.showTrueAnswers,
  'enable_sounds': instance.enableSounds,
  'selected_questions_count': instance.selectedQuestionsCount,
  'selected_units_ids': instance.selectedUnitsIds,
  'selected_lessons_ids': instance.selectedLessonsIds,
  'selected_mode': TestOptionsModel._selectedModeToJson(instance.selectedMode),
  'selected_categories': TestOptionsModel._categoriesToJson(
    instance.selectedCategories,
  ),
  'categories': TestOptionsModel._categoriesToJson(instance.categories),
};
