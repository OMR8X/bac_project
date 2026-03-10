// no imports needed

import '../models/question_model.dart';
import '../../domain/entities/question.dart';
// question_category not needed after refactor

extension QuestionModelExtension on QuestionModel {
  Question get toEntity {
    return Question(
      id: id,
      content: content,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      imageUrl: (this as dynamic).imageUrl as String?,
      categoryId: (this as dynamic).categoryId as int?,
      explain: (this as dynamic).explain as String?,
      questionAnswers: questionAnswers,
      answerEvaluations: answerEvaluations,
    );
  }
}

extension QuestionEntityExtension on Question {
  QuestionModel get toModel {
    return QuestionModel(
      id: id,
      content: content,
      options: options,
      unitId: unitId,
      lessonId: lessonId,
      imageUrl: (this as dynamic).imageUrl as String?,
      categoryId: (this as dynamic).categoryId as int?,
      explain: (this as dynamic).explain as String?,
      questionAnswers: questionAnswers,
      answerEvaluations: answerEvaluations,
    );
  }
}
