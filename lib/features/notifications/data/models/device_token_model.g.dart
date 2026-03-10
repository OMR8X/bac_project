// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTokenModel _$DeviceTokenModelFromJson(Map<String, dynamic> json) =>
    DeviceTokenModel(
      userId: json['user_id'] as String,
      deviceToken: json['device_token'] as String,
      platform: json['platform'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DeviceTokenModelToJson(DeviceTokenModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'device_token': instance.deviceToken,
      'platform': instance.platform,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
