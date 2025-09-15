import '../../domain/entities/option.dart';

class OptionModel extends Option {
  const OptionModel({
    required super.id,
    required super.questionId,
    required super.content,
    required super.isCorrect,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      questionId:
          json['question_id'] as int? ??
          DateTime.now().millisecondsSinceEpoch,
      content: json['content'] as String,
      isCorrect: json['is_correct'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'content': content,
      'is_correct': isCorrect,
    };
  }

  Option toEntity() {
    return Option(
      id: id,
      questionId: questionId,
      content: content,
      isCorrect: isCorrect,
    );
  }

  OptionModel copyWith({
    int? id,
    int? questionId,
    String? content,
    bool? isCorrect,
  }) {
    return OptionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OptionModel &&
        other.id == id &&
        other.questionId == questionId &&
        other.content == content &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      questionId.hashCode ^
      content.hashCode ^
      isCorrect.hashCode;

  @override
  String toString() =>
      'OptionModel(id: $id, questionId: $questionId, content: $content, isCorrect: $isCorrect)';
}
