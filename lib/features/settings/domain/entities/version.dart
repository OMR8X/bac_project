import 'package:equatable/equatable.dart';

class Version extends Equatable {
  final String id;
  final String currentVersion;
  final String minimumVersion;
  final String updateLink;
  final String appVersion;

  const Version({
    this.id = "0",
    required this.currentVersion,
    required this.minimumVersion,
    required this.updateLink,
    this.appVersion = "1.0.0",
  });

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

  factory Version.empty() {
    return Version(
      id: "0",
      currentVersion: "1.0.0",
      minimumVersion: "1.0.0",
      appVersion: "1.0.0",
      updateLink: "",
    );
  }

  @override
  List<Object?> get props => [id, currentVersion, minimumVersion, updateLink];

  @override
  String toString() {
    return 'Version(id: $id, currentVersion: $currentVersion, minimumVersion: $minimumVersion, updateLink: $updateLink, appVersion: $appVersion)';
  }
}
