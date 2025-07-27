import 'package:bac_project/features/tests/domain/entities/option.dart';

class Question {
  final String id;
  final String text;
  final List<Option> options;
  final String category;
  final String? unitId;
  final String? lessonId;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.category,
    this.unitId,
    this.lessonId,
  });

  bool trueAnswers(String answerId) {
    return options.where((option) => option.isCorrect).any((option) => option.id == answerId);
  }

  Question copyWith({
    String? id,
    String? text,
    List<Option>? options,
    String? category,
    String? unitId,
    String? lessonId,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? this.options,
      category: category ?? this.category,
      unitId: unitId ?? this.unitId,
      lessonId: lessonId ?? this.lessonId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Question &&
        other.id == id &&
        other.text == text &&
        other.options == options &&
        other.category == category &&
        other.unitId == unitId &&
        other.lessonId == lessonId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      options.hashCode ^
      category.hashCode ^
      unitId.hashCode ^
      lessonId.hashCode;

  @override
  String toString() =>
      'Question(id: $id, text: $text, options: $options, category: $category, unitId: $unitId, lessonId: $lessonId)';
}
