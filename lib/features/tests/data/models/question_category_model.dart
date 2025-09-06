import '../../domain/entities/question_category.dart';

class QuestionCategoryModel extends QuestionCategory {
  const QuestionCategoryModel({
    required super.id,
    required super.name,
    required super.questionsCount,
  });

  factory QuestionCategoryModel.fromJson(Map<String, dynamic> json) {
    return QuestionCategoryModel(
      id: json['id'],
      name: json['name'],
      questionsCount: json['questions_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'questions_count': questionsCount};
  }
}
