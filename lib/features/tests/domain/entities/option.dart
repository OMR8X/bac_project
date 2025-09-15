class Option {
  final int id;
  final int questionId;
  final String content;
  final bool? isCorrect;

  const Option({
    required this.id,
    required this.questionId,
    required this.content,
    required this.isCorrect,
  });
}
