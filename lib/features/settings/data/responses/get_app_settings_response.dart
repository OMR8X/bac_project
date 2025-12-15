import '../../domain/entities/app_settings.dart';
import '../../domain/entities/version.dart';
import '../models/app_settings_model.dart';

class GetAppSettingsResponse {
  final AppSettings appSettings;

  GetAppSettingsResponse({required this.appSettings});

  factory GetAppSettingsResponse.fromResponse(Map<String, dynamic> json) {
    return GetAppSettingsResponse(
      appSettings: AppSettingsModel.fromJson(json),
    );
  }

  Future<GetAppSettingsResponse> initializeVersionDetails() async {
    final Version initializedVersion = await Version.initialize(appSettings.version);

    final AppSettings updatedAppSettings = AppSettings(
      userData: appSettings.userData,
      motivationalQuote: appSettings.motivationalQuote,
      sections: appSettings.sections,
      governorates: appSettings.governorates,
      version: initializedVersion,
      categories: appSettings.categories,
    );

    return GetAppSettingsResponse(appSettings: updatedAppSettings);
  }
}
