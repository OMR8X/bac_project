import 'package:neuro_app/core/config/supabase_env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Creates a [SupabaseClient] and signs in with the given credentials.
/// Loads the dotenv file automatically if not already initialized.
///
/// Usage in [setUpAll]:
/// ```dart
/// client = await createAuthenticatedClient(
///   email: testTeachers[0].email,
///   password: testAccountPassword,
/// );
/// ```
Future<SupabaseClient> createAuthenticatedClient({
  required String email,
  required String password,
}) async {
  if (!dotenv.isInitialized) await dotenv.load(fileName: '.env');

  final client = SupabaseClient(SupabaseEnv.url, SupabaseEnv.anonKey);
  await client.auth.signInWithPassword(email: email, password: password);

  return client;
}
