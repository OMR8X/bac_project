import '../../domain/entities/question_answer.dart';

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

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAnswerModel(
      id: json['id'] as int,
      resultId: json['result_id'] as int,
      questionId: json['question_id'] as int,
      optionId: json['option_id'] as int?,
      answerText: json['answer_text'] as String?,
      answerPosition: json['answer_position'] as int?,
      isCorrect: json['is_correct'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result_id': resultId,
      'question_id': questionId,
      'option_id': optionId,
      'answer_text': answerText,
      'answer_position': answerPosition,
      'is_correct': isCorrect,
    };
  }

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuestionAnswerModel &&
        other.id == id &&
        other.resultId == resultId &&
        other.questionId == questionId &&
        other.optionId == optionId &&
        other.answerText == answerText &&
        other.answerPosition == answerPosition &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      resultId.hashCode ^
      questionId.hashCode ^
      optionId.hashCode ^
      answerText.hashCode ^
      answerPosition.hashCode ^
      isCorrect.hashCode;

  @override
  String toString() =>
      'QuestionAnswerModel(id: $id, resultId: $resultId, questionId: $questionId, optionId: $optionId, answerText: $answerText, answerPosition: $answerPosition, isCorrect: $isCorrect)';
}
