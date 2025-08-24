import '../../domain/entities/version.dart';
import '../models/version_model.dart';

extension VersionMapper on Version {
  VersionModel get toModel {
    return VersionModel(
      id: id,
      currentVersion: currentVersion,
      minimumVersion: minimumVersion,
      updateLink: updateLink,
      appVersion: appVersion,
    );
  }
}

extension VersionModelMapper on VersionModel {
  Version get toEntity {
    return Version(
      id: id,
      currentVersion: currentVersion,
      minimumVersion: minimumVersion,
      updateLink: updateLink,
      appVersion: appVersion,
    );
  }
}
