import 'api_client.dart';
import 'token_provider.dart';

class ApiManager {
  late final ApiClient _apiClient;

  /// create api client instance
  ApiManager({TokenProvider? tokenProvider}) {
    _apiClient = DioClient(tokenProvider: tokenProvider);
  }

  /// return api client instance
  ApiClient call() {
    return _apiClient;
  }
}
