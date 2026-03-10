// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motivational_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotivationalQuoteModel _$MotivationalQuoteModelFromJson(
  Map<String, dynamic> json,
) => MotivationalQuoteModel(
  quote: json['quote'] as String,
  author: json['author'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$MotivationalQuoteModelToJson(
  MotivationalQuoteModel instance,
) => <String, dynamic>{
  'quote': instance.quote,
  'author': instance.author,
  'created_at': instance.createdAt.toIso8601String(),
};
