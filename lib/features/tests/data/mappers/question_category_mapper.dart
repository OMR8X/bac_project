import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

extension QuestionCategoryMapper on QuestionCategory {
  QuestionCategoryModel get toModel {
    return QuestionCategoryModel(id: id, title: title, questionsCount: questionsCount);
  }
}

extension QuestionCategoryModelMapper on QuestionCategoryModel {
  QuestionCategory get toEntity {
    return QuestionCategory(id: id, title: title, questionsCount: questionsCount);
  }
}
