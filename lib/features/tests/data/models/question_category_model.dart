import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question_category.dart';

part 'question_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionCategoryModel extends QuestionCategory {
  const QuestionCategoryModel({
    required super.id,
    required super.title,
    required super.questionsCount,
    required super.isTypeable,
    required super.isOrderable,
    @JsonKey(name: 'is_mcq') required super.isMCQ,
    required super.isSingleAnswer,
    super.sortOrder,
    super.createdAt,
    super.updatedAt,
  });

  factory QuestionCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCategoryModelToJson(this);
}
