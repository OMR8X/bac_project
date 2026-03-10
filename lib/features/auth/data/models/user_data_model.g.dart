// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      governorateId: (json['governorate_id'] as num).toInt(),
      sectionId: (json['section_id'] as num).toInt(),
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'section_id': instance.sectionId,
      'governorate_id': instance.governorateId,
      'email': instance.email,
    };
