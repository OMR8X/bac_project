class QuestionAnswer {
  final int id;
  final int resultId;
  final int questionId;
  final int? optionId;
  final String? answerText;
  final int? answerPosition;
  final bool? isCorrect;

  const QuestionAnswer({
    this.id = 0,
    this.resultId = 0,
    required this.questionId,
    this.optionId,
    this.answerText,
    this.answerPosition,
    this.isCorrect,
  });

  QuestionAnswer copyWith({
    int? id,
    int? resultId,
    int? questionId,
    int? optionId,
    String? answerText,
    int? answerPosition,
    bool? isCorrect,
  }) {
    return QuestionAnswer(
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
