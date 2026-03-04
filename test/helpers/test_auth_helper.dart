import 'package:dio/dio.dart';
import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'test_credentials.dart';

/// Signs in using email/password via Supabase Auth REST API.
/// Returns a fresh JWT access token.
/// This uses direct HTTP calls (no SDK) so it works in integration tests.
Future<String> signInForTests() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: SupabaseSettings.url,
      headers: {
        'apikey': SupabaseSettings.anonKey,
        'Content-Type': 'application/json',
      },
    ),
  );

  final response = await dio.post(
    '/auth/v1/token?grant_type=password',
    data: {
      'email': testEmail,
      'password': testPassword,
    },
  );

  if (response.statusCode == 200 && response.data['access_token'] != null) {
    return response.data['access_token'] as String;
  } else {
    throw Exception('Failed to sign in: ${response.data}');
  }
}
