import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final int id;
  final int questionId;
  final String content;
  final bool? isCorrect;
  final int? sortOrder;
  final String? typedAnswer;
  final String? imageUrl;

  const Option({
    required this.id,
    required this.questionId,
    required this.content,
    required this.isCorrect,
    this.sortOrder,
    this.typedAnswer,
    this.imageUrl,
  });

  Option copyWith({
    int? id,
    int? questionId,
    String? content,
    bool? isCorrect,
    String? typedAnswer,
    int? sortOrder,
    String? imageUrl,
  }) {
    return Option(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
      sortOrder: sortOrder ?? this.sortOrder,
      typedAnswer: typedAnswer ?? this.typedAnswer,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static Option empty() {
    return Option(
      id: 0,
      questionId: 0,
      content: 'تسلق الانهار',
      isCorrect: false,
      typedAnswer: null,
      sortOrder: null,
      imageUrl: null,
    );
  }

  @override
  List<Object?> get props => [id, questionId, content, isCorrect, sortOrder, typedAnswer, imageUrl];
}
