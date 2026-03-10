import '../../domain/entities/motivational_quote.dart';
import '../models/motivational_quote_model.dart';

extension MotivationalQuoteMapper on MotivationalQuote {
  MotivationalQuoteModel get toModel {
    return MotivationalQuoteModel(quote: quote, author: author, createdAt: createdAt);
  }
}

extension MotivationalQuoteModelMapper on MotivationalQuoteModel {
  MotivationalQuote get toEntity {
    return MotivationalQuote(quote: quote, author: author, createdAt: createdAt);
  }
}
