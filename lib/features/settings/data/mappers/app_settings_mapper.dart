import '../../domain/entities/app_settings.dart';
import '../models/app_settings_model.dart';
import 'version_mappers.dart';

extension AppSettingsMapper on AppSettings {
  AppSettingsModel get toModel {
    return AppSettingsModel(
      sections: sections,
      governorates: governorates,
      categories: categories,
      version: version.toModel,
    );
  }
}

extension AppSettingsModelMapper on AppSettingsModel {
  AppSettings get toEntity {
    return AppSettings(
      sections: sections,
      governorates: governorates,
      version: version,
      categories: categories,
    );
  }
}
