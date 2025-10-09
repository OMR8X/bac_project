class ResultAnswer {
  final int id;
  final int resultId;
  final int questionId;
  final int? optionId;

  const ResultAnswer({
    required this.id,
    required this.resultId,
    required this.questionId,
    this.optionId,
  });
}
