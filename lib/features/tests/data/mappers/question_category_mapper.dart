import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

extension QuestionCategoryMapper on QuestionCategory {
  QuestionCategoryModel toModel() {
    return QuestionCategoryModel(id: id, name: name, questionCount: questionCount);
  }
}

extension QuestionCategoryModelMapper on QuestionCategoryModel {
  QuestionCategory toEntity() {
    return QuestionCategory(id: id, name: name, questionCount: questionCount);
  }
}
