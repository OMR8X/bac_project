import 'package:neuro_app/core/config/supabase_env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Signs in using email/password via Supabase Auth REST API.
/// Returns a fresh JWT access token.
Future<String> signInForTests({
  required String email,
  required String password,
}) async {
  if (!dotenv.isInitialized) await dotenv.load(fileName: '.env');

  final dio = Dio(
    BaseOptions(
      baseUrl: SupabaseEnv.url,
      headers: {
        'apikey': SupabaseEnv.anonKey,
        'Content-Type': 'application/json',
      },
    ),
  );

  Response response;
  try {
    response = await dio.post(
      '/auth/v1/token?grant_type=password',
      data: {
        'email': email,
        'password': password,
      },
    );
  } on DioException catch (e) {
    print('SignIn Error: ${e.response?.data}');
    rethrow;
  }

  if (response.statusCode == 200 && response.data['access_token'] != null) {
    return response.data['access_token'] as String;
  } else {
    throw Exception('Failed to sign in: ${response.data}');
  }
}
