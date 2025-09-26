import '../../domain/entities/option.dart';

class OptionModel extends Option {
  const OptionModel({
    required super.id,
    required super.questionId,
    required super.content,
    required super.isCorrect,
    super.sortOrder,
    super.typedAnswer,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      questionId: json['question_id'] as int? ?? 0, // Default to 0 when not provided
      content: json['content'] as String,
      isCorrect: json['is_correct'] as bool?,
      sortOrder: json['sort_order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'content': content,
      'is_correct': isCorrect,
      'sort_order': sortOrder,
    };
  }

  Option toEntity() {
    return Option(
      id: id,
      questionId: questionId,
      content: content,
      isCorrect: isCorrect,
      sortOrder: sortOrder,
      typedAnswer: typedAnswer,
    );
  }

  @override
  OptionModel copyWith({
    int? id,
    int? questionId,
    String? content,
    bool? isCorrect,
    String? typedAnswer,
    int? sortOrder,
  }) {
    return OptionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
      sortOrder: sortOrder ?? this.sortOrder,
      typedAnswer: typedAnswer ?? this.typedAnswer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OptionModel &&
        other.id == id &&
        other.questionId == questionId &&
        other.content == content &&
        other.isCorrect == isCorrect &&
        other.sortOrder == sortOrder &&
        other.typedAnswer == typedAnswer;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      questionId.hashCode ^
      content.hashCode ^
      isCorrect.hashCode ^
      sortOrder.hashCode ^
      typedAnswer.hashCode;

  @override
  String toString() =>
      'OptionModel(id: $id, questionId: $questionId, content: $content, isCorrect: $isCorrect, sortOrder: $sortOrder, typedAnswer: $typedAnswer)';
}
