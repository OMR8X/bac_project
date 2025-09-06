import '../../domain/entities/motivational_quote.dart';

class MotivationalQuoteModel extends MotivationalQuote {
  MotivationalQuoteModel({required super.quote, required super.author, required super.date});

  factory MotivationalQuoteModel.fromJson(Map<String, dynamic> json) {
    return MotivationalQuoteModel(
      quote: json['quote'] as String,
      author: json['author'] as String,
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'quote': quote, 'author': author, 'date': date.toIso8601String()};
  }
}
