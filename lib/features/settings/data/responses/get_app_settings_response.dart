import '../../domain/entities/app_settings.dart';
import '../models/app_settings_model.dart';

class GetAppSettingsResponse {
  final AppSettings appSettings;

  GetAppSettingsResponse({required this.appSettings});

  factory GetAppSettingsResponse.fromResponse(Map<String, dynamic> json) {
    return GetAppSettingsResponse(
      appSettings: AppSettingsModel.fromJson(json),
    );
  }
}
