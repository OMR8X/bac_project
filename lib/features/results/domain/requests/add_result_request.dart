import 'package:bac_project/features/tests/data/mappers/question_answer_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

class AddResultRequest {
  final TestMode? testMode;
  final int? lessonId;
  final int durationSeconds;
  final List<int> questionsIds;
  final List<QuestionAnswer> questionsAnswers;

  const AddResultRequest({
    required this.testMode,
    required this.lessonId,
    required this.durationSeconds,
    required this.questionsIds,
    required this.questionsAnswers,
  });

  Map<String, dynamic> toJsonBody() {
    return {
      'is_test_mode': testMode == TestMode.testing,
      'lesson_id': lessonId,
      'duration_seconds': durationSeconds,
      'questions_ids': questionsIds,
      'questions_answers': questionsAnswers.map((a) => a.toModel().toJson()).toList(),
    };
  }
}
