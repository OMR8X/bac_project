import 'package:json_annotation/json_annotation.dart';

part 'device_token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeviceTokenModel {
  final String userId;

  final String deviceToken;

  final String platform;

  final DateTime updatedAt;

  DeviceTokenModel({
    required this.userId,
    required this.deviceToken,
    required this.platform,
    required this.updatedAt,
  });

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) => _$DeviceTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenModelToJson(this);

  Map<String, dynamic> toMap() => toJson();

  static DeviceTokenModel create({
    required String userId,
    required String deviceToken,
    required String platform,
  }) {
    return DeviceTokenModel(
      userId: userId,
      deviceToken: deviceToken,
      platform: platform,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
