import '../../domain/entities/app_settings.dart';
import '../models/app_settings_model.dart';

class GetAppSettingsResponse {
  final String message;
  final AppSettings appSettings;

  GetAppSettingsResponse({required this.message, required this.appSettings});

  factory GetAppSettingsResponse.fromResponse(Map<String, dynamic> json) {
    return GetAppSettingsResponse(
      message: json['message'] as String? ?? '',
      appSettings: AppSettingsModel.fromJson(json),
    );
  }
}
