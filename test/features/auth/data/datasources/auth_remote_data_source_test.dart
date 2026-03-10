import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';

import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late String token;
  late TestApiManager testApiManager;
  late AuthRemoteDataSourceImplements dataSource;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);
    dataSource = AuthRemoteDataSourceImplements(
      apiManager: testApiManager,
      supabaseClient: MockSupabaseClient(),
    );
  });

  group('changePassword', () {
    test('placeholder test', () async {
      // TODO: Implement changePassword tests.
    });
  });

  group('forgetPassword', () {
    test('placeholder test', () async {
      // TODO: Implement forgetPassword tests.
    });
  });

  group('signIn', () {
    test('placeholder test', () async {
      // TODO: Implement signIn tests.
    });
  });

  group('signUp', () {
    test('placeholder test', () async {
      // TODO: Implement signUp tests.
    });
  });

  group('updateUserData', () {
    test('placeholder test', () async {
      // TODO: Implement updateUserData tests.
    });
  });

  group('signOut', () {
    test('placeholder test', () async {
      // TODO: Implement signOut tests.
    });
  });

  group('getUserData', () {
    test('placeholder test', () async {
      // TODO: Implement getUserData tests.
    });
  });

  group('addToUserFavorites', () {
    test('placeholder test', () async {
      // TODO: Implement addToUserFavorites tests.
    });
  });

  group('removeFromUserFavorites', () {
    test('placeholder test', () async {
      // TODO: Implement removeFromUserFavorites tests.
    });
  });

  group('updatePassword', () {
    test('placeholder test', () async {
      // TODO: Implement updatePassword tests.
    });
  });

  group('getUserFavorites', () {
    test('placeholder test', () async {
      // TODO: Implement getUserFavorites tests.
    });
  });
}
