import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source_impl.dart';
import '../../../helpers/test_auth_helper.dart';
import '../../../helpers/test_api_manager.dart';

void main() {
  group('Tests Datasource Integration Tests', () {
    late String authToken;
    late TestApiManager testApiManager;
    late SupabaseClient supabaseClient;
    late TestsRemoteDataSource dataSource;

    setUpAll(() async {
      authToken = await signInForTests();
      testApiManager = TestApiManager(authToken);
      supabaseClient = Supabase.instance.client;
      dataSource = TestsRemoteDataSourceImpl(
        apiManager: testApiManager,
        client: supabaseClient,
      );
    });

    group('getUnits', () {
      test('should return units list', () async {
        // TODO: Implement real API call test
      });
    });

    group('getLessons', () {
      test('should return lessons for unit', () async {
        // TODO: Implement real API call test
      });
    });

    group('getQuestions', () {
      test('should return questions for criteria', () async {
        // TODO: Implement real API call test
      });
    });

    group('getTestOptions', () {
      test('should return test options', () async {
        // TODO: Implement real API call test
      });
    });
  });
}
