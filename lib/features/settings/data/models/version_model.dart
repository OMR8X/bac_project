import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/version.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VersionModel extends Version {
  const VersionModel({
    required super.id,
    required super.currentVersion,
    required super.minimumVersion,
    required super.updateLink,
    @JsonKey(defaultValue: '1.0.0') super.appVersion,
    @JsonKey(fromJson: _buildNumberFromJson) super.buildNumber,
  });

  // Kept: DB field might be string for build number or int
  static String _buildNumberFromJson(dynamic value) => (value ?? '0').toString();

  factory VersionModel.fromJson(Map<String, dynamic> json) => _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
