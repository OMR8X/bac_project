import '../models/result_answer_model.dart';
import '../../domain/entities/result_answer.dart';

extension ResultAnswerModelExtension on ResultAnswerModel {
  ResultAnswer get toEntity {
    return ResultAnswer(id: id, resultId: resultId, questionId: questionId, optionId: optionId);
  }
}

extension ResultAnswerEntityExtension on ResultAnswer {
  ResultAnswerModel get toModel {
    return ResultAnswerModel(
      id: id,
      resultId: resultId,
      questionId: questionId,
      optionId: optionId,
    );
  }
}
