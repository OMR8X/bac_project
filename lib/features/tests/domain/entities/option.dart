class Option {
  final int id;
  final int questionId;
  final String text;
  final bool isCorrect;

  const Option({
    required this.id,
    required this.questionId,
    required this.text,
    required this.isCorrect,
  });
}
