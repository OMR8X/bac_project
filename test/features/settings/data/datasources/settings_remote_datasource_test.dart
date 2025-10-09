// ignore_for_file: unnecessary_null_comparison

import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/settings/data/datasources/settings_remote_datasource_impl.dart';
import 'package:bac_project/features/settings/data/responses/get_app_settings_response.dart';
import 'package:bac_project/features/settings/domain/requests/get_app_settings_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late SettingsRemoteDatasourceImpl dataSource;

  setUp(() async {
    ///
    SharedPreferences.setMockInitialValues({});

    ///
    await Supabase.initialize(
      url: SupabaseSettings.url,
      anonKey: SupabaseSettings.anonKey,
    );

    ///
    final apiManager = ApiManager();

    ///
    dataSource = SettingsRemoteDatasourceImpl(
      apiManager: apiManager,
    );
  });

  group('SettingsRemoteDatasourceImpl', () {
    group('getAppSettings', () {
      test('should return GetAppSettingsResponse', () async {
        // Arrange
        final request = GetAppSettingsRequest();

        // Act & Assert - Method should return expected type
        final response = await dataSource.getAppSettings(request: request);
        expect(response, isA<GetAppSettingsResponse>());
      });
    });
  });
}
