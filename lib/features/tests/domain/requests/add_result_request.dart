import '../../data/models/user_answer_model.dart';

class AddResultRequest {
  final int? lessonId;
  final List<int> questionsIds;
  final int durationSeconds;
  final List<UserAnswerModel> answers;

  const AddResultRequest({
    this.lessonId,
    required this.questionsIds,
    required this.durationSeconds,
    required this.answers,
  });

  Map<String, dynamic> toJsonBody() {
    return {
      if (lessonId != null) 'p_lesson_id': lessonId,
      'p_questions_ids': questionsIds,
      'p_duration_seconds': durationSeconds,
      'p_answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}
