import 'package:bac_project/features/tests/data/models/question_model.dart';

import '../../domain/entities/question.dart';

class GetQuestionsResponse {
  final List<Question> questions;

  const GetQuestionsResponse({required this.questions});

  GetQuestionsResponse copyWith({List<Question>? questions}) {
    return GetQuestionsResponse(questions: questions ?? this.questions);
  }

  factory GetQuestionsResponse.fromJson(Map<String, dynamic> json) {
    final questions =
        (json['questions'] as List?)?.map((question) {
          return QuestionModel.fromJson(question as Map<String, dynamic>);
        }).toList() ??
        [];

    return GetQuestionsResponse(questions: questions);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetQuestionsResponse && other.questions == questions;
  }

  @override
  int get hashCode => questions.hashCode;

  @override
  String toString() => 'GetQuestionsResponse(questions: $questions)';
}
