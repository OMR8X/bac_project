// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTokenModel _$DeviceTokenModelFromJson(Map<String, dynamic> json) =>
    DeviceTokenModel(
      userId: json['user_id'] as String,
      deviceBrand: json['device_brand'] as String,
      deviceModel: json['device_model'] as String,
      deviceToken: json['device_token'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DeviceTokenModelToJson(DeviceTokenModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'device_brand': instance.deviceBrand,
      'device_model': instance.deviceModel,
      'device_token': instance.deviceToken,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
