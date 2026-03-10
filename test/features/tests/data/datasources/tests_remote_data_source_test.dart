import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/tests/data/datasources/tests_remote_data_source_impl.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:neuro_app/core/config/supabase_env.dart';

void main() {
  late String token;
  late TestApiManager testApiManager;
  late TestsRemoteDataSourceImpl dataSource;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);
    dataSource = TestsRemoteDataSourceImpl(
      client: SupabaseClient(SupabaseEnv.url, SupabaseEnv.anonKey),
      apiManager: testApiManager,
    );
  });

  group('getUnits', () {
    test('placeholder test', () async {
      // TODO: Implement getUnits tests.
    });
  });

  group('getLessons', () {
    test('placeholder test', () async {
      // TODO: Implement getLessons tests.
    });
  });

  group('getQuestions', () {
    test('placeholder test', () async {
      // TODO: Implement getQuestions tests.
    });
  });

  group('getQuestionsByIds', () {
    test('placeholder test', () async {
      // TODO: Implement getQuestionsByIds tests.
    });
  });

  group('getTestOptions', () {
    test('placeholder test', () async {
      // TODO: Implement getTestOptions tests.
    });
  });
}
