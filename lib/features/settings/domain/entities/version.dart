import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Version extends Equatable {
  final String id;
  final String currentVersion;
  final String minimumVersion;
  final String updateLink;
  final String appVersion;
  final String buildNumber;

  const Version({
    this.id = "0",
    required this.currentVersion,
    required this.minimumVersion,
    required this.updateLink,
    this.appVersion = "1.0.0",
    this.buildNumber = "0",
  });

  static Future<Version> initialize(Version version) async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      return Version(
        id: version.id,
        currentVersion: version.currentVersion,
        minimumVersion: version.minimumVersion,
        updateLink: version.updateLink,
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    } catch (_) {
      return version;
    }
  }

  bool get updateRequired {
    int app = int.parse(appVersion.replaceAll(".", ""));
    int minimum = int.parse(minimumVersion.replaceAll(".", ""));
    return app < minimum;
  }

  bool get updateAvailable {
    int app = int.parse(appVersion.replaceAll(".", ""));
    int current = int.parse(currentVersion.replaceAll(".", ""));
    return app < current;
  }

  String get versionString {
    return "$currentVersion ($appVersion+$buildNumber)";
  }

  factory Version.empty() {
    return Version(
      id: "0",
      currentVersion: "1.0.0",
      minimumVersion: "1.0.0",
      appVersion: "1.0.0",
      buildNumber: "0",
      updateLink: "",
    );
  }

  @override
  List<Object?> get props {
    return [id, currentVersion, minimumVersion, updateLink, appVersion, buildNumber];
  }

  @override
  String toString() {
    return 'Version(id: $id, currentVersion: $currentVersion, minimumVersion: $minimumVersion, updateLink: $updateLink, appVersion: $appVersion)';
  }
}
