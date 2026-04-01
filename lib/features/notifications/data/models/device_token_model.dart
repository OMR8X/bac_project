import 'package:json_annotation/json_annotation.dart';

part 'device_token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeviceTokenModel {
  final String userId;

  final String deviceBrand;

  final String deviceModel;

  final String deviceToken;

  final DateTime updatedAt;

  final DateTime? createdAt;

  DeviceTokenModel({
    required this.userId,
    required this.deviceBrand,
    required this.deviceModel,
    required this.deviceToken,
    required this.updatedAt,
    this.createdAt,
  });

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) => _$DeviceTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenModelToJson(this);

  Map<String, dynamic> toMap() => toJson();

  static DeviceTokenModel create({
    required String userId,
    required String deviceBrand,
    required String deviceModel,
    required String deviceToken,
  }) {
    return DeviceTokenModel(
      userId: userId,
      deviceBrand: deviceBrand,
      deviceModel: deviceModel,
      deviceToken: deviceToken,
      updatedAt: DateTime.now().toUtc(),
      createdAt: DateTime.now().toUtc(),
    );
  }
}
