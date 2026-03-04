import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract interface for providing authentication tokens.
abstract class TokenProvider {
  Future<String?> getToken();
}

/// Production token provider using Supabase session.
class SupabaseTokenProvider implements TokenProvider {
  @override
  Future<String?> getToken() async {
    return Supabase.instance.client.auth.currentSession?.accessToken;
  }
}

/// Static token provider for tests with a pre-configured token.
class StaticTokenProvider implements TokenProvider {
  final String? _token;

  StaticTokenProvider(this._token);

  @override
  Future<String?> getToken() async => _token;
}
