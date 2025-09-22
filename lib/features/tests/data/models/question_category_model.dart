import '../../domain/entities/question_category.dart';

class QuestionCategoryModel extends QuestionCategory {
  const QuestionCategoryModel({
    required super.id,
    required super.title,
    required super.questionsCount,
    required super.isTypeable,
    required super.isOrderable,
    required super.isMCQ,
    required super.isSingleAnswer,
  });

  factory QuestionCategoryModel.fromJson(Map<String, dynamic> json) {
    return QuestionCategoryModel(
      id: json['id'],
      title: json['title'],
      questionsCount: json['questions_count'],
      isTypeable: json['is_typeable'],
      isOrderable: json['is_orderable'],
      isMCQ: json['is_mcq'],
      isSingleAnswer: json['is_single_answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions_count': questionsCount,
      'is_typeable': isTypeable,
      'is_orderable': isOrderable,
      'is_mcq': isMCQ,
      'is_single_answer': isSingleAnswer,
    };
  }
}
