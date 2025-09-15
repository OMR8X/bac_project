import '../../domain/entities/question_category.dart';

class QuestionCategoryModel extends QuestionCategory {
  const QuestionCategoryModel({
    required super.id,
    required super.title,
    required super.questionsCount,
  });

  factory QuestionCategoryModel.fromJson(Map<String, dynamic> json) {
    return QuestionCategoryModel(
      id: json['id'],
      title: json['title'],
      questionsCount: json['questions_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'questions_count': questionsCount};
  }
}
