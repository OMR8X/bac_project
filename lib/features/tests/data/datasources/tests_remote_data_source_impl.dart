import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';

import '../../domain/requests/get_units_request.dart';
import '../../domain/requests/get_lessons_request.dart';
import '../../domain/requests/get_test_options_request.dart';
import '../../domain/requests/get_questions_request.dart';
import '../responses/get_units_response.dart';
import '../responses/get_lessons_response.dart';
import '../responses/get_test_options_response.dart';
import 'tests_remote_data_source.dart';
import '../../../../core/services/local/local_json_data_api.dart';

class TestsRemoteDataSourceImpl implements TestsRemoteDataSource {
  @override
  Future<GetUnitsResponse> getUnits(GetUnitsRequest request) async {
    /// Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    /// Load units from JSON
    final allUnits = await LocalJsonDataApi.fetchUnits();

    /// Return units
    return GetUnitsResponse(units: allUnits, totalCount: allUnits.length);
  }

  @override
  Future<GetLessonsResponse> getLessons(GetLessonsRequest request) async {
    /// Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    /// Load lessons from JSON
    final allLessons = await LocalJsonDataApi.fetchLessons();

    /// Filter by unitId if provided
    var filteredLessons = allLessons;
    if (request.unitId != null) {
      filteredLessons = allLessons.where((lesson) => lesson.unitId == request.unitId).toList();
    }

    ///
    return GetLessonsResponse(lessons: filteredLessons, totalCount: filteredLessons.length);
  }

  @override
  Future<GetTestOptionsResponse> getTestOptions(GetTestOptionsRequest request) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    // Load test options from JSON
    var testOptions = await LocalJsonDataApi.fetchTestOptions();

    // Create a copy with modified IDs based on request
    if (request.unitIds != null && request.unitIds!.isNotEmpty) {
      testOptions = testOptions.copyWith(
        unitIds: request.unitIds,
        id: 'units_${request.unitIds!.join('_')}_options',
      );
    } else if (request.lessonIds != null && request.lessonIds!.isNotEmpty) {
      testOptions = testOptions.copyWith(
        lessonIds: request.lessonIds,
        id: 'lessons_${request.lessonIds!.join('_')}_options',
      );
    }

    return GetTestOptionsResponse(testOptions: testOptions);
  }

  @override
  Future<GetQuestionsResponse> getQuestions(GetQuestionsRequest request) async {
    /// Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    /// Load questions from JSON
    final allQuestions = await LocalJsonDataApi.fetchQuestions();

    /// Filter by lessonId
    final filteredQuestions =
        allQuestions.where((question) {
          return request.lessonsIds.contains(question.lessonId);
        }).toList();

    /// Return questions
    return GetQuestionsResponse(questions: filteredQuestions);
  }
}
