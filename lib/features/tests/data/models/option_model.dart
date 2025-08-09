import '../../domain/entities/option.dart';

class OptionModel extends Option {
  const OptionModel({required super.id, required super.text, required super.isCorrect});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      text: json['text'] as String,
      isCorrect: json['is_correct'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'is_correct': isCorrect};
  }

  Option toEntity() {
    return Option(id: id, text: text, isCorrect: isCorrect);
  }

  OptionModel copyWith({int? id, String? text, bool? isCorrect}) {
    return OptionModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OptionModel &&
        other.id == id &&
        other.text == text &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ isCorrect.hashCode;

  @override
  String toString() => 'AnswerModel(id: $id, text: $text, isCorrect: $isCorrect)';
}
