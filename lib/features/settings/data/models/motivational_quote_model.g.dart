// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motivational_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotivationalQuoteModel _$MotivationalQuoteModelFromJson(
  Map<String, dynamic> json,
) => MotivationalQuoteModel(
  id: (json['id'] as num?)?.toInt(),
  quote: json['quote'] as String,
  author: json['author'] as String,
  used: json['used'] as bool?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$MotivationalQuoteModelToJson(
  MotivationalQuoteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'quote': instance.quote,
  'author': instance.author,
  'used': instance.used,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
