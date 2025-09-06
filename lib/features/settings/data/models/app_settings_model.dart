import 'package:bac_project/features/auth/data/mappers/governorate_mappers.dart';
import 'package:bac_project/features/auth/data/mappers/section_mappers.dart';
import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/auth/data/models/governorate_model.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';
import 'package:bac_project/features/settings/data/mappers/motivational_quote_mapper.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/data/mappers/question_category_mapper.dart';
import '../../domain/entities/app_settings.dart';
import 'version_model.dart';
import '../mappers/version_mappers.dart';
import 'motivational_quote_model.dart';

class AppSettingsModel extends AppSettings {
  AppSettingsModel({
    required super.userData,
    required super.motivationalQuote,
    required super.sections,
    required super.governorates,
    required super.version,
    required super.categories,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      userData:
          json['user_data'] != null
              ? UserDataModel.fromJson(json['user_data'] as Map<String, dynamic>)
              : null,
      motivationalQuote:
          json['motivational_quote'] != null
              ? MotivationalQuoteModel.fromJson(json['motivational_quote'] as Map<String, dynamic>)
              : null,
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionModel.fromJson(e as Map<String, dynamic>).toEntity)
              .toList() ??
          [],
      governorates:
          (json['governorates'] as List<dynamic>?)
              ?.map((e) => GovernorateModel.fromJson(e))
              .toList() ??
          [],
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => QuestionCategoryModel.fromJson(e as Map<String, dynamic>).toEntity())
              .toList() ??
          [],
      version: VersionModel.fromJson(json['version'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sections': sections.map((s) => s.toModel.toJson()).toList(),
      'governorates': governorates.map((g) => g.toModel.toJson()).toList(),
      'categories': categories.map((c) => c.toModel().toJson()).toList(),
      'version': version.toModel.toJson(),
      'motivational_quote': motivationalQuote?.toModel().toJson(),
    };
  }
}
