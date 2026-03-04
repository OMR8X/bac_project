import 'package:bac_project/core/services/api/api_client.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/token_provider.dart';

/// Test API Manager that reuses the app's DioClient with a static token.
class TestApiManager extends ApiManager {
  final ApiClient _testClient;

  TestApiManager(String token)
    : _testClient = DioClient(tokenProvider: StaticTokenProvider(token)),
      super();

  @override
  ApiClient call() => _testClient;
}
