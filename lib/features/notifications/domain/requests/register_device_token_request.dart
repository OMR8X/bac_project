import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class RegisterDeviceTokenRequest {
  final String deviceBrand;
  final String deviceModel;
  final String deviceToken;

  RegisterDeviceTokenRequest({
    required this.deviceBrand,
    required this.deviceModel,
    required this.deviceToken,
  });

  static Future<RegisterDeviceTokenRequest> fromDeviceToken(String deviceToken) async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceBrand = 'Unknown Device';
    String deviceModelName = 'Unknown Device';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceBrand = androidInfo.brand;
      deviceModelName = androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceBrand = iosInfo.name;
      deviceModelName = iosInfo.model;
    }
    return RegisterDeviceTokenRequest(
      deviceBrand: deviceBrand,
      deviceModel: deviceModelName,
      deviceToken: deviceToken,
    );
  }

  Map<String, dynamic> toJsonBody() {
    return {
      'p_device_brand': deviceBrand,
      'p_device_model': deviceModel,
      'p_device_token': deviceToken,
    };
  }
}
