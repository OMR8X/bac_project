import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Holds environment and device information for the application.
class EnvironmentInfo extends Equatable {
  final String deviceModel;
  final String deviceBrand;
  final String appVersion;
  final String buildNumber;
  final String platform;
  final String osVersion;
  final bool isPhysicalDevice;

  const EnvironmentInfo({
    required this.deviceModel,
    required this.deviceBrand,
    required this.appVersion,
    required this.buildNumber,
    required this.platform,
    required this.osVersion,
    required this.isPhysicalDevice,
  });

  /// Initializes environment info from device and package info plugins.
  static Future<EnvironmentInfo> initialize() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String deviceModel = 'Unknown';
    String deviceBrand = 'Unknown';
    String platform = 'unknown';
    String osVersion = 'Unknown';
    bool isPhysicalDevice = true;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
      deviceBrand = androidInfo.brand;
      platform = 'android';
      osVersion = androidInfo.version.release;
      isPhysicalDevice = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceModel = iosInfo.model;
      deviceBrand = iosInfo.name;
      platform = 'ios';
      osVersion = iosInfo.systemVersion;
      isPhysicalDevice = iosInfo.isPhysicalDevice;
    }

    return EnvironmentInfo(
      deviceModel: deviceModel,
      deviceBrand: deviceBrand,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      platform: platform,
      osVersion: osVersion,
      isPhysicalDevice: isPhysicalDevice,
    );
  }

  /// Creates an empty/fallback instance.
  factory EnvironmentInfo.empty() {
    return const EnvironmentInfo(
      deviceModel: 'Unknown',
      deviceBrand: 'Unknown',
      appVersion: '1.0.0',
      buildNumber: '0',
      platform: 'unknown',
      osVersion: 'Unknown',
      isPhysicalDevice: false,
    );
  }

  /// Returns true if running on Android.
  bool get isAndroid => platform == 'android';

  /// Returns true if running on iOS.
  bool get isIOS => platform == 'ios';

  /// Returns a formatted version string (e.g., "1.0.0+42").
  String get versionString => '$appVersion+$buildNumber';

  @override
  List<Object?> get props => [
    deviceModel,
    deviceBrand,
    appVersion,
    buildNumber,
    platform,
    osVersion,
    isPhysicalDevice,
  ];

  @override
  String toString() {
    return 'EnvironmentInfo(deviceModel: $deviceModel, deviceBrand: $deviceBrand, appVersion: $appVersion, buildNumber: $buildNumber, platform: $platform, osVersion: $osVersion, isPhysicalDevice: $isPhysicalDevice)';
  }
}
