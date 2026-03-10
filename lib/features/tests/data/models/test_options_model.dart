import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/tests/domain/entities/test_options.dart';
import 'package:neuro_app/features/tests/domain/entities/question_category.dart';
import 'package:neuro_app/features/tests/domain/entities/test_mode.dart';
import 'package:neuro_app/features/tests/data/models/question_category_model.dart';

part 'test_options_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TestOptionsModel extends TestOptions {
  @override
  // Kept: custom enum converter
  @JsonKey(fromJson: _selectedModeFromJson, toJson: _selectedModeToJson)
  final TestMode selectedMode;

  @override
  // Kept: custom list converter
  @JsonKey(
    fromJson: _categoriesFromJson,
    toJson: _categoriesToJson,
  )
  final List<QuestionCategory>? selectedCategories;

  @override
  // Kept: custom list converter
  @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  final List<QuestionCategory>? categories;

  const TestOptionsModel({
    required super.selectedQuestionsCount,
    super.selectedUnitsIds,
    super.selectedLessonsIds,
    required super.enableSounds,
    required super.showTrueAnswers,
    required this.selectedMode,
    this.selectedCategories,
    this.categories,
  }) : super(
         selectedMode: selectedMode,
         selectedCategories: selectedCategories,
         categories: categories,
       );

  static TestMode _selectedModeFromJson(String name) => TestMode.values.byName(name);
  static String _selectedModeToJson(TestMode mode) => mode.name;

  static List<QuestionCategory>? _categoriesFromJson(List<dynamic>? json) =>
      json?.map((e) => QuestionCategoryModel.fromJson(e as Map<String, dynamic>)).toList();

  static List<Map<String, dynamic>>? _categoriesToJson(List<QuestionCategory>? categories) =>
      categories
          ?.map(
            (e) =>
                QuestionCategoryModel(
                  id: e.id,
                  title: e.title,
                  questionsCount: e.questionsCount,
                  isTypeable: e.isTypeable,
                  isOrderable: e.isOrderable,
                  isMCQ: e.isMCQ,
                  isSingleAnswer: e.isSingleAnswer,
                ).toJson(),
          )
          .toList();

  factory TestOptionsModel.fromJson(Map<String, dynamic> json) => _$TestOptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestOptionsModelToJson(this);
}
