class Option {
  final int id;
  final int questionId;
  final String content;
  final bool? isCorrect;
  final int? sortOrder;
  final String? typedAnswer;

  const Option({
    required this.id,
    required this.questionId,
    required this.content,
    required this.isCorrect,
    this.sortOrder,
    this.typedAnswer,
  });

  Option copyWith({
    int? id,
    int? questionId,
    String? content,
    bool? isCorrect,
    String? typedAnswer,
    int? sortOrder,
  }) {
    return Option(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
      sortOrder: sortOrder ?? this.sortOrder,
      typedAnswer: typedAnswer ?? this.typedAnswer,
    );
  }

  static Option empty() {
    return Option(
      id: 0,
      questionId: 0,
      content: 'تسلق الانهار',
      isCorrect: false,
      typedAnswer: null,
      sortOrder: null,
    );
  }
}
