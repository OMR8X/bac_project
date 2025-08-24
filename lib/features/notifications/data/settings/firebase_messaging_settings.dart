import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/injector/app_injection.dart';

class AppRemoteNotificationsSettings {
  //
  static final bool showAlert = false;
  static final bool showBadge = false;
  static final bool showSound = false;
  //
  static final List<String> defaultTopicList = [
    "updates-${sl<PackageInfo>().version.replaceAll(".", "-")}",
  ];
}
