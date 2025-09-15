import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/responses/api_response.dart';
import '../../domain/requests/get_app_settings_request.dart';
import '../responses/get_app_settings_response.dart';
import 'settings_remote_datasource.dart';

class SettingsRemoteDatasourceImpl implements SettingsRemoteDatasource {
  final ApiManager apiManager;

  SettingsRemoteDatasourceImpl({required this.apiManager});

  @override
  Future<GetAppSettingsResponse> getAppSettings({required GetAppSettingsRequest request}) async {
    // Call the Supabase RPC function to get app settings
    final response = await apiManager().get(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getAppSettingsFunctionEndpoint),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    // Parse and return response
    return GetAppSettingsResponse.fromResponse(apiResponse.data);
  }
}
