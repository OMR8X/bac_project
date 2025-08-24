import 'package:bac_project/features/settings/data/responses/get_app_settings_response.dart';
import '../../domain/requests/get_app_settings_request.dart';

abstract class SettingsRemoteDatasource {
  Future<GetAppSettingsResponse> getAppSettings({required GetAppSettingsRequest request});
}
