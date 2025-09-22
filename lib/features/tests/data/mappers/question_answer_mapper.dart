import 'package:bac_project/features/tests/data/models/question_answer_model.dart';

import '../../domain/entities/question_answer.dart';

extension QuestionAnswerModelExtension on QuestionAnswerModel {
  QuestionAnswer toEntity() {
    return QuestionAnswer(
      id: id,
      resultId: resultId,
      questionId: questionId,
      optionId: optionId,
      answerText: answerText,
      answerPosition: answerPosition,
      isCorrect: isCorrect,
    );
  }
}

extension QuestionAnswerEntityExtension on QuestionAnswer {
  QuestionAnswerModel toModel() {
    return QuestionAnswerModel(
      id: id,
      resultId: resultId,
      questionId: questionId,
      optionId: optionId,
      answerText: answerText,
      answerPosition: answerPosition,
      isCorrect: isCorrect,
    );
  }
}
