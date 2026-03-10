import 'package:flutter_test/flutter_test.dart';
import 'package:neuro_app/features/reports/data/datasources/exception_reports_remote_datasource.dart';
import 'package:neuro_app/core/services/environment/environment_info.dart';
import '../../../../helpers/integration/test_auth_helper.dart';
import '../../../../helpers/integration/test_api_manager.dart';
import '../../../../helpers/integration/test_credentials.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  late String token;
  late TestApiManager testApiManager;
  late ExceptionReportsRemoteDatasourceImplementation dataSource;
  late EnvironmentInfo environmentInfo;

  setUpAll(() async {
    token = await signInForTests(
      email: testStudents[0].email,
      password: testAccountPassword,
    );
    testApiManager = TestApiManager(token);

    // We mock the package info for EnvironmentInfo since we're in a test environment
    PackageInfo.setMockInitialValues(
      appName: 'test_app',
      packageName: 'com.example.test',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: 'buildSignature',
      installerStore: 'installerStore',
    );
    environmentInfo = await EnvironmentInfo.initialize();

    dataSource = ExceptionReportsRemoteDatasourceImplementation(
      apiManager: testApiManager,
      environmentInfo: environmentInfo,
    );
  });

  group('submitExceptionReport', () {
    test('placeholder test', () async {
      // TODO: Implement submitExceptionReport tests.
    });
  });
}
