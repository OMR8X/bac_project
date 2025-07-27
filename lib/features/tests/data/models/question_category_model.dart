import '../../domain/entities/question_category.dart';

class QuestionCategoryModel extends QuestionCategory {
  const QuestionCategoryModel({
    required super.id,
    required super.name,
    required super.questionCount,
  });

  factory QuestionCategoryModel.fromJson(Map<String, dynamic> json) {
    return QuestionCategoryModel(
      id: json['id'],
      name: json['name'],
      questionCount: json['question_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'question_count': questionCount};
  }
}
