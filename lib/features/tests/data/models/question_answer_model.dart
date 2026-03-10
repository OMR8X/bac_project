import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question_answer.dart';

part 'question_answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionAnswerModel extends QuestionAnswer {
  const QuestionAnswerModel({
    required super.id,
    required super.resultId,
    required super.questionId,
    super.optionId,
    super.answerText,
    super.answerPosition,
    super.isCorrect,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswerModelToJson(this);

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

  @override
  QuestionAnswerModel copyWith({
    int? id,
    int? resultId,
    int? questionId,
    int? optionId,
    String? answerText,
    int? answerPosition,
    bool? isCorrect,
  }) {
    return QuestionAnswerModel(
      id: id ?? this.id,
      resultId: resultId ?? this.resultId,
      questionId: questionId ?? this.questionId,
      optionId: optionId ?? this.optionId,
      answerText: answerText ?? this.answerText,
      answerPosition: answerPosition ?? this.answerPosition,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
