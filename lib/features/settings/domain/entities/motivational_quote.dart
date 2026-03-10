import 'package:equatable/equatable.dart';

class MotivationalQuote extends Equatable {
  final String quote;
  final String author;
  final DateTime createdAt;

  const MotivationalQuote({required this.quote, required this.author, required this.createdAt});

  @override
  List<Object?> get props => [quote, author, createdAt];
}
