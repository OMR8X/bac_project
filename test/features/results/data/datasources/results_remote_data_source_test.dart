// ignore_for_file: unnecessary_null_comparison

import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/results/data/datasources/results_remote_data_source_impl.dart';
import 'package:bac_project/features/results/data/responses/add_result_response.dart';
import 'package:bac_project/features/results/data/responses/get_answer_evaluations_response.dart';
import 'package:bac_project/features/results/data/responses/get_result_leaderboard_response.dart';
import 'package:bac_project/features/results/data/responses/get_result_questions_details_response.dart';
import 'package:bac_project/features/results/data/responses/get_result_response.dart';
import 'package:bac_project/features/results/data/responses/get_results_response.dart';
import 'package:bac_project/features/results/domain/requests/add_result_request.dart';
import 'package:bac_project/features/results/domain/requests/get_answer_evaluations_request.dart';
import 'package:bac_project/features/results/domain/requests/get_my_results_request.dart';
import 'package:bac_project/features/results/domain/requests/get_result_leaderboard_request.dart';
import 'package:bac_project/features/results/domain/requests/get_result_questions_details_request.dart';
import 'package:bac_project/features/results/domain/requests/get_result_request.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late ResultsRemoteDataSourceImpl dataSource;

  setUp(() async {
    ///
    SharedPreferences.setMockInitialValues({});

    ///
    await Supabase.initialize(
      url: SupabaseSettings.url,
      anonKey: SupabaseSettings.anonKey,
    );

    ///
    final apiManager = ApiManager();

    ///
    dataSource = ResultsRemoteDataSourceImpl(
      apiManager: apiManager,
    );
  });

  group('ResultsRemoteDataSourceImpl', () {
    group('addResult', () {
      test('should return AddResultResponse', () async {
        // Arrange
        final request = AddResultRequest(
          testMode: TestMode.testing,
          lessonId: 1,
          durationSeconds: 1800,
          questionsIds: [1, 2, 3],
          questionsAnswers: [],
        );

        // Act & Assert - Method should return expected type
        final response = await dataSource.addResult(request);
        expect(response, isA<AddResultResponse>());
      });
    });

    group('getMyResults', () {
      test('should return GetResultsResponse', () async {
        // Arrange
        final request = GetMyResultsRequest();

        // Act & Assert - Method should return expected type
        final response = await dataSource.getMyResults(request);
        expect(response, isA<GetResultsResponse>());
      });
    });

    group('getResult', () {
      test('should return GetResultResponse', () async {
        // Arrange
        final request = GetResultRequest(resultId: 1);

        // Act & Assert - Method should return expected type
        final response = await dataSource.getResult(request);
        expect(response, isA<GetResultResponse>());
      });
    });

    group('getResultLeaderboard', () {
      test('should return GetResultLeaderboardResponse', () async {
        // Arrange
        final request = GetResultLeaderboardRequest(resultId: 1);

        // Act & Assert - Method should return expected type
        final response = await dataSource.getResultLeaderboard(request);
        expect(response, isA<GetResultLeaderboardResponse>());
      });
    });

    group('getResultQuestionsDetails', () {
      test('should return GetResultQuestionsDetailsResponse', () async {
        // Arrange
        final request = GetResultQuestionsDetailsRequest(resultId: 1);

        // Act & Assert - Method should return expected type
        final response = await dataSource.getResultQuestionsDetails(request);
        expect(response, isA<GetResultQuestionsDetailsResponse>());
      });
    });

    group('getAnswerEvaluations', () {
      test('should return GetAnswerEvaluationsResponse', () async {
        // Arrange
        final request = GetAnswerEvaluationsRequest(answerIds: [1, 2, 3]);

        // Act & Assert - Method should return expected type
        final response = await dataSource.getAnswerEvaluations(request);
        expect(response, isA<GetAnswerEvaluationsResponse>());
      });
    });
  });
}
