import 'package:equatable/equatable.dart';

class MotivationalQuote extends Equatable {
  final int? id;
  final String quote;
  final String author;
  final bool? used;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const MotivationalQuote({
    this.id,
    required this.quote,
    required this.author,
    this.used,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, quote, author, used, createdAt, updatedAt];
}
