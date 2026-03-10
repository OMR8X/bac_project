// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingsModel _$AppSettingsModelFromJson(Map<String, dynamic> json) =>
    AppSettingsModel(
      userData: AppSettingsModel._userDataFromJson(
        json['user_data'] as Map<String, dynamic>?,
      ),
      motivationalQuote: AppSettingsModel._quoteFromJson(
        json['motivational_quote'] as Map<String, dynamic>?,
      ),
      sections:
          json['sections'] == null
              ? []
              : AppSettingsModel._sectionsFromJson(json['sections'] as List?),
      governorates:
          json['governorates'] == null
              ? []
              : AppSettingsModel._governoratesFromJson(
                json['governorates'] as List?,
              ),
      version: AppSettingsModel._versionFromJson(
        json['version'] as Map<String, dynamic>,
      ),
      categories:
          json['categories'] == null
              ? []
              : AppSettingsModel._categoriesFromJson(
                json['categories'] as List?,
              ),
    );

Map<String, dynamic> _$AppSettingsModelToJson(
  AppSettingsModel instance,
) => <String, dynamic>{
  'user_data': AppSettingsModel._userDataToJson(instance.userData),
  'motivational_quote': AppSettingsModel._quoteToJson(
    instance.motivationalQuote,
  ),
  'sections': AppSettingsModel._sectionsToJson(instance.sections),
  'governorates': AppSettingsModel._governoratesToJson(instance.governorates),
  'version': AppSettingsModel._versionToJson(instance.version),
  'categories': AppSettingsModel._categoriesToJson(instance.categories),
};
