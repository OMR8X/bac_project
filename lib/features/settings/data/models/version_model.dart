import '../../domain/entities/version.dart';

class VersionModel extends Version {
  const VersionModel({
    required super.id,
    required super.currentVersion,
    required super.minimumVersion,
    required super.updateLink,
    super.appVersion,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      id: json['id'].toString(),
      currentVersion: json['current_version'],
      minimumVersion: json['minimum_version'],
      updateLink: json['update_link'],
      appVersion: json['app_version'] ?? '1.0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'current_version': currentVersion,
      'minimum_version': minimumVersion,
      'update_link': updateLink,
      'app_version': appVersion,
    };
  }
}
