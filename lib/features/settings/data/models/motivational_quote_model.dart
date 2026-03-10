import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/motivational_quote.dart';

part 'motivational_quote_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MotivationalQuoteModel extends MotivationalQuote {
  MotivationalQuoteModel({
    required super.quote,
    required super.author,
    @JsonKey(fromJson: _dateFromJson) required super.createdAt,
  });

  static DateTime _dateFromJson(String? dateStr) =>
      dateStr != null ? DateTime.parse(dateStr) : DateTime.now();

  factory MotivationalQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$MotivationalQuoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MotivationalQuoteModelToJson(this);
}
