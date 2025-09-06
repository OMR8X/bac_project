import '../../domain/entities/motivational_quote.dart';
import '../models/motivational_quote_model.dart';

extension MotivationalQuoteMapper on MotivationalQuote {
  MotivationalQuoteModel toModel() {
    return MotivationalQuoteModel(quote: quote, author: author, date: date);
  }
}

extension MotivationalQuoteModelMapper on MotivationalQuoteModel {
  MotivationalQuote toEntity() {
    return MotivationalQuote(quote: quote, author: author, date: date);
  }
}
