import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  // Set token
  Future<void> setToken({required String token}) async {
    return await const FlutterSecureStorage().write(key: "token", value: token);
  }

  // Set token
  Future<String?> getToken() async {
    final token = await const FlutterSecureStorage().read(key: "token");
    return token;
  }

  // Delete token
  Future<void> deleteToken() async {
    await const FlutterSecureStorage().delete(key: "token");
  }
}
