class QuestionCategory {
  final int id;
  final String title;
  final bool isTypeable;
  final bool isOrderable;
  final bool isMCQ;
  final bool isSingleAnswer;
  final int? questionsCount;
  const QuestionCategory({
    required this.id,
    required this.title,
    this.questionsCount,
    required this.isTypeable,
    required this.isOrderable,
    required this.isMCQ,
    required this.isSingleAnswer,
  });

  @override
  String toString() {
    return 'QuestionCategory(id: $id, title: $title, isTypeable: $isTypeable, isOrderable: $isOrderable, isMCQ: $isMCQ, isSingleAnswer: $isSingleAnswer, questionsCount: $questionsCount)';
  }
}
