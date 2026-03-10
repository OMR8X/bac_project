import 'package:neuro_app/features/tests/data/models/question_answer_model.dart';
import 'package:neuro_app/features/tests/domain/entities/test_mode.dart';
import 'package:neuro_app/features/results/domain/entities/result_test_mode.dart';
import 'package:neuro_app/features/results/data/models/result_model.dart';
import 'package:neuro_app/features/results/data/models/answer_evaluation_model.dart';
import 'package:neuro_app/features/results/data/models/result_answer_model.dart';

import 'package:neuro_app/features/results/domain/requests/add_result_request.dart';
import 'package:neuro_app/features/results/domain/requests/get_my_results_request.dart';
import 'package:neuro_app/features/results/domain/requests/get_result_request.dart';
import 'package:neuro_app/features/results/domain/requests/get_result_leaderboard_request.dart';
import 'package:neuro_app/features/results/domain/requests/get_result_questions_details_request.dart';
import 'package:neuro_app/features/results/domain/requests/get_answer_evaluations_request.dart';

import 'package:neuro_app/features/results/data/responses/add_result_response.dart';
import 'package:neuro_app/features/results/data/responses/get_results_response.dart';
import 'package:neuro_app/features/results/data/responses/get_result_response.dart';
import 'package:neuro_app/features/results/data/responses/get_result_leaderboard_response.dart';
import 'package:neuro_app/features/results/data/responses/get_result_questions_details_response.dart';
import 'package:neuro_app/features/results/data/responses/get_answer_evaluations_response.dart';
import 'package:neuro_app/features/tests/data/models/question_model.dart';

/// Centralized test fixtures and dummy data for the [Results] feature.
/// Keeping these here avoids duplicating dummy data across dozens of test files
/// and ensures consistency. If the data shape changes, we only need to update it here.
class ResultsTestFixtures {
  // =========================================================================
  // 1. DUMMY MODELS & ENTITIES
  // =========================================================================

  /// A dummy [QuestionAnswerModel] for testing.
  static final dummyQuestionAnswer = QuestionAnswerModel(
    id: 101,
    resultId: 1,
    questionId: 201,
    optionId: 301,
    answerText: 'Sample text answer',
    answerPosition: 2,
    isCorrect: true,
  );

  /// A dummy [ResultModel] instance to reuse across tests.
  static final tResultModel = ResultModel(
    id: 1,
    userId: 'user-123',
    lessonId: 10,
    lessonTitle: 'Math 101',
    resultOrder: 5,
    totalQuestions: 20,
    correctAnswers: 15,
    wrongAnswers: 5,
    score: 75.0,
    durationSeconds: 1200,
    resultTestMode: ResultTestMode.testing,
    questionAnswers: [dummyQuestionAnswer],
    createdAt: DateTime(2023, 1, 1),
    updatedAt: DateTime(2023, 1, 1),
  );

  static final tAnswerEvaluationModel = AnswerEvaluationModel(
    id: 1,
    questionAnswerId: 101,
    isCorrect: true,
    confidence: 0.95,
    notes: 'Great job!',
    modelName: 'gpt-4',
    createdAt: DateTime(2023, 1, 1),
    updatedAt: DateTime(2023, 1, 1),
  );

  static final tResultAnswerModel = ResultAnswerModel(
    id: 1,
    resultId: 1,
    questionId: 201,
    optionId: 301,
  );

  static final tQuestionModel = QuestionModel(
    id: 201,
    content: 'What is 2+2?',
    options: const [],
    lessonId: 10,
  );

  // =========================================================================
  // 2. DUMMY JSON MAPS (API payload simulation)
  // =========================================================================

  static final Map<String, dynamic> tResultJson = {
    'id': 1,
    'user_id': 'user-123',
    'lesson_id': 10,
    'lesson_title': 'Math 101',
    'user_rank': 5,
    'total_questions': 20,
    'correct_answers': 15,
    'wrong_answers': 5,
    'score': 75.0,
    'duration_seconds': 1200,
    'is_test_mode': true,
    'question_answers': [
      {
        'id': 101,
        'result_id': 1,
        'question_id': 201,
        'option_id': 301,
        'answer_text': 'Sample text answer',
        'answer_position': 2,
        'is_correct': true,
      },
    ],
    'created_at': DateTime(2023, 1, 1).toIso8601String(),
    'updated_at': DateTime(2023, 1, 1).toIso8601String(),
  };

  static final Map<String, dynamic> tAnswerEvaluationJson = {
    'id': 1,
    'question_answer_id': 101,
    'is_correct': true,
    'confidence': 0.95,
    'notes': 'Great job!',
    'model_name': 'gpt-4',
    'created_at': DateTime(2023, 1, 1).toIso8601String(),
    'updated_at': DateTime(2023, 1, 1).toIso8601String(),
  };

  static final Map<String, dynamic> tResultAnswerJson = {
    'id': 1,
    'result_id': 1,
    'question_id': 201,
    'option_id': 301,
  };

  static final Map<String, dynamic> tQuestionJson = {
    'id': 201,
    'content': 'What is 2+2?',
    'lesson_id': 10,
    'question_type_id': 1,
    'created_at': DateTime(2023, 1, 1).toIso8601String(),
    'updated_at': DateTime(2023, 1, 1).toIso8601String(),
  };

  static final Map<String, dynamic> tGetResultsResponseJson = {
    'results': [tResultJson],
  };

  static final Map<String, dynamic> tGetResultResponseJson = {
    'result': tResultJson,
    'previous_results': [tResultJson],
  };

  static final Map<String, dynamic> tGetResultLeaderboardResponseJson = {
    'results': [tResultJson],
  };

  static final Map<String, dynamic> tGetResultQuestionsDetailsResponseJson = {
    'questions': [tQuestionJson],
  };

  static final Map<String, dynamic> tGetAnswerEvaluationsResponseJson = {
    'answers_evaluations': [tAnswerEvaluationJson],
  };

  // =========================================================================
  // 3. DUMMY REQUESTS
  // =========================================================================

  static final tAddResultRequest = AddResultRequest(
    testMode: TestMode.testing,
    lessonId: 10,
    durationSeconds: 1200,
    questionsIds: [201],
    questionsAnswers: [dummyQuestionAnswer],
  );

  static const tGetMyResultsRequest = GetMyResultsRequest(
    lessonId: 10,
    limit: 20,
    offset: 0,
  );

  static const tGetResultRequest = GetResultRequest(resultId: 1);
  static const tGetResultLeaderboardRequest = GetResultLeaderboardRequest(resultId: 1);
  static const tGetResultQuestionsDetailsRequest = GetResultQuestionsDetailsRequest(resultId: 1);
  static const tGetAnswerEvaluationsRequest = GetAnswerEvaluationsRequest(answerIds: [101]);

  // =========================================================================
  // 4. PRE-BUILT RESPONSES
  // =========================================================================

  static final tAddResultResponse = AddResultResponse(result: tResultModel);
  static final tGetResultsResponse = GetResultsResponse(results: [tResultModel]);
  static final tGetResultResponse = GetResultResponse(
    result: tResultModel,
    previousResults: [tResultModel],
  );
  static final tGetResultLeaderboardResponse = GetResultLeaderboardResponse(
    topResults: [tResultModel],
  );
  static final tGetResultQuestionsDetailsResponse = GetResultQuestionsDetailsResponse(
    resultQuestions: [tQuestionModel],
  );
  static final tGetAnswerEvaluationsResponse = GetAnswerEvaluationsResponse(
    answerEvaluations: [tAnswerEvaluationModel],
  );
}
