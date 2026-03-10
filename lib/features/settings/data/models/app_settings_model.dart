import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/auth/data/mappers/governorate_mappers.dart';
import 'package:neuro_app/features/auth/data/mappers/section_mappers.dart';
import 'package:neuro_app/features/auth/data/models/section_model.dart';
import 'package:neuro_app/features/auth/data/models/governorate_model.dart';
import 'package:neuro_app/features/auth/data/models/user_data_model.dart';
import 'package:neuro_app/features/settings/domain/entities/app_settings.dart';
import 'package:neuro_app/features/auth/domain/entites/user_data.dart';
import 'package:neuro_app/features/settings/domain/entities/section.dart';
import 'package:neuro_app/features/settings/domain/entities/governorate.dart';
import 'package:neuro_app/features/settings/data/mappers/motivational_quote_mapper.dart';
import 'package:neuro_app/features/tests/data/models/question_category_model.dart';
import 'package:neuro_app/features/tests/data/mappers/question_category_mapper.dart';
import 'package:neuro_app/features/tests/domain/entities/question_category.dart';
import '../../domain/entities/motivational_quote.dart';
import '../../domain/entities/version.dart';
import 'version_model.dart';
import '../mappers/version_mappers.dart';
import 'motivational_quote_model.dart';

part 'app_settings_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppSettingsModel extends AppSettings {
  @override
  @JsonKey(name: 'user_data', fromJson: _userDataFromJson, toJson: _userDataToJson)
  final UserData? userData;

  @override
  @JsonKey(name: 'motivational_quote', fromJson: _quoteFromJson, toJson: _quoteToJson)
  final MotivationalQuote? motivationalQuote;

  @override
  @JsonKey(defaultValue: [], fromJson: _sectionsFromJson, toJson: _sectionsToJson)
  final List<Section> sections;

  @override
  @JsonKey(defaultValue: [], fromJson: _governoratesFromJson, toJson: _governoratesToJson)
  final List<Governorate> governorates;

  @override
  @JsonKey(fromJson: _versionFromJson, toJson: _versionToJson)
  final Version version;

  @override
  @JsonKey(defaultValue: [], fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  final List<QuestionCategory> categories;

  const AppSettingsModel({
    required this.userData,
    required this.motivationalQuote,
    required this.sections,
    required this.governorates,
    required this.version,
    required this.categories,
  }) : super(
         userData: userData,
         motivationalQuote: motivationalQuote,
         sections: sections,
         governorates: governorates,
         version: version,
         categories: categories,
       );

  static UserData? _userDataFromJson(Map<String, dynamic>? json) =>
      json != null ? UserDataModel.fromJson(json) : null;
  static Map<String, dynamic>? _userDataToJson(UserData? data) =>
      data != null ? (data as UserDataModel).toJson() : null;

  static MotivationalQuote? _quoteFromJson(Map<String, dynamic>? json) =>
      json != null ? MotivationalQuoteModel.fromJson(json) : null;
  static Map<String, dynamic>? _quoteToJson(MotivationalQuote? quote) => quote?.toModel.toJson();

  static List<Section> _sectionsFromJson(List<dynamic>? json) =>
      json?.map((e) => SectionModel.fromJson(e as Map<String, dynamic>).toEntity).toList() ?? [];
  static List<Map<String, dynamic>> _sectionsToJson(List<Section> sections) =>
      sections.map((s) => s.toModel.toJson()).toList();

  static List<Governorate> _governoratesFromJson(List<dynamic>? json) =>
      json?.map((e) => GovernorateModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  static List<Map<String, dynamic>> _governoratesToJson(List<Governorate> governorates) =>
      governorates.map((g) => g.toModel.toJson()).toList();

  static Version _versionFromJson(Map<String, dynamic> json) => VersionModel.fromJson(json);
  static Map<String, dynamic> _versionToJson(Version version) => version.toModel.toJson();

  static List<QuestionCategory> _categoriesFromJson(List<dynamic>? json) =>
      json
          ?.map((e) => QuestionCategoryModel.fromJson(e as Map<String, dynamic>).toEntity)
          .toList() ??
      [];
  static List<Map<String, dynamic>> _categoriesToJson(List<QuestionCategory> categories) =>
      categories.map((c) => c.toModel.toJson()).toList();

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) => _$AppSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsModelToJson(this);
}
