import '../../domain/entities/app_settings.dart';
import '../models/app_settings_model.dart';
import 'version_mappers.dart';
import 'motivational_quote_mapper.dart';

extension AppSettingsMapper on AppSettings {
  AppSettingsModel get toModel {
    return AppSettingsModel(
      userData: userData,
      motivationalQuote: motivationalQuote?.toModel(),
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
      userData: userData,
      motivationalQuote: motivationalQuote,
      sections: sections,
      governorates: governorates,
      version: version,
      categories: categories,
    );
  }
}
