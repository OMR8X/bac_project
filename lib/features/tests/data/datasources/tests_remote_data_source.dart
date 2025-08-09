import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';

import '../../domain/requests/get_units_request.dart';
import '../../domain/requests/get_lessons_request.dart';
import '../../domain/requests/get_test_options_request.dart';
import '../../domain/requests/get_questions_request.dart';
import '../responses/get_lessons_response.dart';
import '../responses/get_units_response.dart';

abstract class TestsRemoteDataSource {
  Future<GetUnitsResponse> getUnits(GetUnitsRequest request);
  Future<GetLessonsResponse> getLessons(GetLessonsRequest request);
  Future<GetQuestionsResponse> getQuestions(GetQuestionsRequest request);
}
