import '../../data/models/user_answer_model.dart';

class AddResultRequest {
  final int? lessonId;
  final int durationSeconds;
  final List<int> questionsIds;
  final List<UserAnswerModel> answers;

  const AddResultRequest({
    required this.lessonId,
    required this.durationSeconds,
    required this.questionsIds,
    required this.answers,
  });

  Map<String, dynamic> toJsonBody() {
    return {
      'lesson_id': lessonId,
      'duration_seconds': durationSeconds,
      'questions_ids': questionsIds,
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}
