import 'package:bac_project/features/tests/data/models/result_answer_model.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';

extension ResultAnswerModelExtension on ResultAnswerModel {
  ResultAnswer toEntity() {
    return ResultAnswer(id: id, resultId: resultId, questionId: questionId, optionId: optionId);
  }
}

extension ResultAnswerEntityExtension on ResultAnswer {
  ResultAnswerModel toModel() {
    return ResultAnswerModel(id: id, resultId: resultId, questionId: questionId, optionId: optionId);
  }
}
