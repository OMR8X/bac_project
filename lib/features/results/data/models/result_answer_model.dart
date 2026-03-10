import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/result_answer.dart';

part 'result_answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResultAnswerModel extends ResultAnswer {
  const ResultAnswerModel({
    required super.id,
    required super.resultId,
    required super.questionId,
    super.optionId,
  });

  factory ResultAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$ResultAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultAnswerModelToJson(this);
}
