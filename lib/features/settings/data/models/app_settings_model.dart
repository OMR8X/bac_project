import 'package:bac_project/features/auth/data/mappers/governorate_mappers.dart';
import 'package:bac_project/features/auth/data/mappers/section_mappers.dart';
import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/auth/data/models/governorate_model.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/data/mappers/question_category_mapper.dart';
import '../../domain/entities/app_settings.dart';
import 'version_model.dart';
import '../mappers/version_mappers.dart';

class AppSettingsModel extends AppSettings {
  AppSettingsModel({
    required super.sections,
    required super.governorates,
    required super.version,
    required super.categories,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
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
    };
  }
}
