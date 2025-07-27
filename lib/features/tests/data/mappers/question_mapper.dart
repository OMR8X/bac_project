import 'package:bac_project/features/tests/data/models/option_model.dart';

import '../models/question_model.dart';
import '../../domain/entities/question.dart';

extension QuestionModelExtension on QuestionModel {
  Question toEntity() {
    return Question(
      id: id,
      text: text,
      options: options,
      category: category,
      unitId: unitId,
      lessonId: lessonId,
    );
  }
}

extension QuestionEntityExtension on Question {
  QuestionModel toModel() {
    return QuestionModel(
      id: id,
      text: text,
      options: options,
      category: category,
      unitId: unitId,
      lessonId: lessonId,
    );
  }
}
