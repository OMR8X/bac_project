// no imports needed

import '../models/question_model.dart';
import '../../domain/entities/question.dart';
// question_category not needed after refactor

extension QuestionModelExtension on QuestionModel {
  Question toEntity() {
    return Question(
      id: id,
      content: content,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      imageUrl: (this as dynamic).imageUrl as String?,
      categoryId: (this as dynamic).categoryId as int?,
      isMCQ: (this as dynamic).isMCQ as bool?,
      explain: (this as dynamic).explain as String?,
      questionAnswers: questionAnswers,
      answerEvaluations: answerEvaluations,
    );
  }
}

extension QuestionEntityExtension on Question {
  QuestionModel toModel() {
    return QuestionModel(
      id: id,
      content: content,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      imageUrl: (this as dynamic).imageUrl as String?,
      categoryId: (this as dynamic).categoryId as int?,
      isMCQ: (this as dynamic).isMCQ as bool?,
      explain: (this as dynamic).explain as String?,
      questionAnswers: questionAnswers,
      answerEvaluations: answerEvaluations,
    );
  }
}
