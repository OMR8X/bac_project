import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/settings/data/datasources/settings_remote_datasource_impl.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';

void main() {
  late String token;
  late TestApiManager testApiManager;
  late SettingsRemoteDatasourceImpl dataSource;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);
    dataSource = SettingsRemoteDatasourceImpl(apiManager: testApiManager);
  });

  group('getAppSettings', () {
    test('placeholder test', () async {
      // TODO: Implement getAppSettings tests.
    });
  });
}
