import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/features/settings/data/datasources/settings_remote_datasource_impl.dart';
import 'package:bac_project/features/settings/domain/requests/get_app_settings_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SettingsRemoteDatasourceImpl dataSource;
  late ApiManager apiManager;

  setUp(() {
    apiManager = ApiManager();
    dataSource = SettingsRemoteDatasourceImpl(apiManager: apiManager);
  });

  group('SettingsRemoteDatasourceImpl', () {
    group('getAppSettings', () {
      test(
        'should return GetAppSettingsResponse when app settings are fetched successfully',
        () async {
          // Arrange
          final request = GetAppSettingsRequest();

          // Act

          // Assert
        },
      );

      test('should throw exception when fetching app settings fails', () async {
        // Arrange
        final request = GetAppSettingsRequest();

        // Act

        // Assert
      });
    });
  });
}
