import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/features/tests/data/models/lesson_model.dart';
import 'package:bac_project/features/tests/data/models/unit_model.dart';
import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';
import 'package:bac_project/features/tests/data/responses/get_test_options_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/lesson.dart';
import '../../domain/requests/get_units_request.dart';
import '../../domain/requests/get_lessons_request.dart';
import '../../domain/requests/get_questions_request.dart';
import '../../domain/requests/get_questions_by_ids_request.dart';
import '../../domain/requests/get_test_options_request.dart';
import '../responses/get_units_response.dart';
import '../responses/get_lessons_response.dart';
import 'tests_remote_data_source.dart';
import '../../../../core/services/local/local_json_data_api.dart';

class TestsRemoteDataSourceImpl implements TestsRemoteDataSource {
  final SupabaseClient client;
  final ApiManager apiManager;

  TestsRemoteDataSourceImpl({required this.client, required this.apiManager});

  @override
  Future<GetUnitsResponse> getUnits(GetUnitsRequest request) async {
    /// Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final query = await apiManager().get(SupabaseEndpoints.rpc(SupabaseEndpoints.getTotalUnitsFunctionEndpoint));

    /// Return units
    return GetUnitsResponse.fromJson(query.data);
  }

  @override
  Future<GetLessonsResponse> getLessons(GetLessonsRequest request) async {
    ///
    final query = await apiManager().post(SupabaseEndpoints.rpc(SupabaseEndpoints.getTotalLessonsFunctionEndpoint), body: request.toJsonBody());

    ///
    return GetLessonsResponse.fromJson(query.data);
  }

  @override
  Future<GetQuestionsResponse> getQuestions(GetQuestionsRequest request) async {
    ///
    final query = await apiManager().post(SupabaseEndpoints.rpc(SupabaseEndpoints.getLessonsQuestionsFunctionEndpoint), body: request.toJsonBody());

    /// Return questions
    return GetQuestionsResponse.fromJson(query.data);
  }

  @override
  Future<GetQuestionsResponse> getQuestionsByIds(GetQuestionsByIdsRequest request) async {
    ///
    final query = await apiManager().post(SupabaseEndpoints.rpc(SupabaseEndpoints.getQuestionsByIdsFunctionEndpoint), body: request.toJsonBody());

    /// Return questions
    return GetQuestionsResponse.fromJson(query.data);
  }

  @override
  Future<GetTestOptionsResponse> getTestOptions(GetTestOptionsRequest request) async {
    ///
    final query = await apiManager().post(SupabaseEndpoints.rpc(SupabaseEndpoints.getTestOptionsFunctionEndpoint), body: request.toJsonBody());

    /// Return test options
    return GetTestOptionsResponse.fromJson(query.data);
  }
}
