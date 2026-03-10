// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
  id: (json['id'] as num).toInt(),
  currentVersion: json['current_version'] as String,
  minimumVersion: json['minimum_version'] as String,
  updateLink: json['update_link'] as String,
  appVersion: json['app_version'] as String? ?? '1.0.0',
  buildNumber: json['build_number'] as String? ?? "0",
);

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'current_version': instance.currentVersion,
      'minimum_version': instance.minimumVersion,
      'update_link': instance.updateLink,
      'app_version': instance.appVersion,
      'build_number': instance.buildNumber,
    };
