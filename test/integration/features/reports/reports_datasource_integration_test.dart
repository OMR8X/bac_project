import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/token_provider.dart';
import 'package:bac_project/core/services/environment/environment_info.dart';
import 'package:bac_project/features/reports/data/datasources/exception_reports_remote_datasource.dart';
import 'package:bac_project/features/reports/domain/requests/exception_report_request.dart';
import '../../../helpers/test_auth_helper.dart';

void main() {
  group('Reports Datasource Integration Tests', () {
    late ApiManager apiManager;
    late EnvironmentInfo environmentInfo;
    late ExceptionReportsRemoteDatasource dataSource;

    setUpAll(() async {
      // Sign in to get authenticated session and retrieve the token
      final token = await signInForTests();

      // Initialize API manager with static token provider for tests
      apiManager = ApiManager(tokenProvider: StaticTokenProvider(token));

      // Use empty environment info for testing (avoids platform dependencies)
      environmentInfo = EnvironmentInfo.empty();

      dataSource = ExceptionReportsRemoteDatasourceImplementation(
        apiManager: apiManager,
        environmentInfo: environmentInfo,
      );
    });

    group('submitExceptionReport', () {
      test('should successfully submit exception report', () async {
        final request = ExceptionReportRequest(
          exceptionType: 'TestException',
          message: 'This is a test exception from integration test',
          stackTrace: 'at test_file.dart:1\nat test_runner.dart:10',
          trigger: 'integration_test',
        );

        // Should complete without throwing
        await expectLater(
          dataSource.submitExceptionReport(request),
          completes,
        );
      });

      test('should submit report with minimal required fields', () async {
        final request = ExceptionReportRequest(
          exceptionType: 'MinimalTestException',
          message: 'Minimal test exception',
        );

        await expectLater(
          dataSource.submitExceptionReport(request),
          completes,
        );
      });
    });
  });
}
