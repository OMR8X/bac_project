import 'package:neuro_app/features/tests/data/models/question_answer_model.dart';

import '../../domain/entities/question_answer.dart';

extension QuestionAnswerModelExtension on QuestionAnswerModel {
  QuestionAnswer get toEntity {
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
  QuestionAnswerModel get toModel {
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
