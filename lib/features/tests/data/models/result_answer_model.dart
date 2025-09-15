import 'package:bac_project/features/tests/domain/entities/result_answer.dart';

class ResultAnswerModel extends ResultAnswer {
  const ResultAnswerModel({
    required super.id,
    required super.resultId,
    required super.questionId,
    required super.optionId,
  });

  factory ResultAnswerModel.fromJson(Map<String, dynamic> json) {
    return ResultAnswerModel(
      id: json['id'] as int,
      resultId: json['result_id'] as int,
      questionId: json['question_id'] as int,
      optionId: json['option_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'result_id': resultId, 'question_id': questionId, 'option_id': optionId};
  }
}
