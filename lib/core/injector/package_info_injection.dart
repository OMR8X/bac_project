import 'package:bac_project/core/injector/app_injection.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> packageInfoInjection() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  sl.registerSingleton<PackageInfo>(packageInfo);
}
