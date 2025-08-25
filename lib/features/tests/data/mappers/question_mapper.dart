import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';

import '../models/question_model.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_category.dart';

extension QuestionModelExtension on QuestionModel {
  Question toEntity() {
    return Question(
      id: id,
      text: text,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      image: (this as dynamic).image as String?,
      category: (this as dynamic).category as QuestionCategory?,
    );
  }
}

extension QuestionEntityExtension on Question {
  QuestionModel toModel() {
    return QuestionModel(
      id: id,
      text: text,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      image: (this as dynamic).image as String?,
      category: (this as dynamic).category as QuestionCategory?,
    );
  }
}
