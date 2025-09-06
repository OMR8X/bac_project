import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/entities/user_answer.dart';

import '../../data/models/user_answer_model.dart';

class AddResultRequest {
  final int? lessonId;
  final List<int> questionsIds;
  final int durationSeconds;
  final List<UserAnswerModel> answers;

  const AddResultRequest({required this.lessonId, required this.questionsIds, required this.durationSeconds, required this.answers});

  Map<String, dynamic> toJsonBody() {
    return {
      'lesson_id': lessonId,
      'questions_ids': questionsIds,
      'duration_seconds': durationSeconds,
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}
