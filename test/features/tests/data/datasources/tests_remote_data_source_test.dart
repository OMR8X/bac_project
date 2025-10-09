// ignore_for_file: unnecessary_null_comparison

import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source_impl.dart';
import 'package:bac_project/features/tests/data/responses/get_lessons_response.dart';
import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';
import 'package:bac_project/features/tests/data/responses/get_test_options_response.dart';
import 'package:bac_project/features/tests/data/responses/get_units_response.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/domain/entities/test_options.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_by_ids_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_test_options_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_units_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late TestsRemoteDataSource dataSource;

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
    dataSource = TestsRemoteDataSourceImpl(
      client: Supabase.instance.client,
      apiManager: apiManager,
    );
  });

  group('TestsRemoteDataSource', () {
    group('testing get units', () {
      test('should return list of units', () async {
        // Arrange
        final request = GetUnitsRequest();
        // Act & Assert - Method should return expected type
        final unitsResponse = await dataSource.getUnits(request);
        expect(unitsResponse, isA<GetUnitsResponse>());
      });
    });

    group('testing get lessons', () {
      test('should return list of lessons', () async {
        // Arrange
        final request = GetLessonsRequest(unitId: 1);

        // Act & Assert - Method should return expected type
        final lessonsResponse = await dataSource.getLessons(request);
        expect(lessonsResponse, isA<GetLessonsResponse>());
        expect(lessonsResponse.lessons.isNotEmpty, isTrue);
      });
    });
    group('testing get test options', () {
      test('get test options for units', () async {
        // Arrange
        final request = GetTestOptionsRequest(
          unitIds: [1.toString()],
        );

        // Act & Assert - Method should return expected type
        final GetTestOptionsResponse response = await dataSource.getTestOptions(request);
        expect(response, isA<GetTestOptionsResponse>());
      });
      test('get test options for lessons', () async {
        // Arrange
        final request = GetTestOptionsRequest(
          lessonIds: [1.toString()],
        );

        // Act & Assert - Method should return expected type
        final GetTestOptionsResponse response = await dataSource.getTestOptions(request);
        expect(response, isA<GetTestOptionsResponse>());
      });
    });
    group('testing get questions', () {
      test('should return list of questions for list of lessons', () async {
        // Arrange
        final request = GetQuestionsRequest(
          options: TestOptions(
            selectedMode: TestMode.exploring,
            selectedCategories: [QuestionCategory.mock()],
            selectedLessonsIDs: [1],
            enableSounds: true,
            showTrueAnswers: true,
          ),
        );

        // Act & Assert - Method should return expected type
        final questionsResponse = await dataSource.getQuestions(request);
        expect(questionsResponse, isA<GetQuestionsResponse>());
      });
      test('should return list of questions for lesson', () async {
        // Arrange
        final request = GetQuestionsRequest(
          options: TestOptions(
            selectedMode: TestMode.exploring,
            selectedCategories: [QuestionCategory.mock()],
            enableSounds: true,
            showTrueAnswers: true,
          ),
        );

        // Act & Assert - Method should return expected type
        final questionsResponse = await dataSource.getQuestions(request);
        expect(questionsResponse, isA<GetQuestionsResponse>());
      });
    });

    group('testing get questions by ids', () {
      test('should return list of questions', () async {
        // Arrange
        final request = GetQuestionsByIdsRequest(questionIds: []);

        // Act & Assert - Method should return expected type
        final questionsByIdsResponse = await dataSource.getQuestionsByIds(request);
        expect(questionsByIdsResponse, isA<GetQuestionsResponse>());
      });
    });
  });
}
