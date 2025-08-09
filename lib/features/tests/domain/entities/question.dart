import 'package:bac_project/features/tests/domain/entities/option.dart';

class Question {
  //
  final int id;
  final String text;
  //
  final int? unitId;
  final int? lessonId;
  //
  final List<Option> options;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    this.unitId,
    this.lessonId,
  });

  bool trueAnswers(String answerId) {
    return options.where((option) => option.isCorrect).any((option) => option.id == answerId);
  }

  Question copyWith({int? id, String? text, List<Option>? options, int? unitId, int? lessonId}) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? this.options,
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
        other.unitId == unitId &&
        other.lessonId == lessonId;
  }

  @override
  int get hashCode =>
      id.hashCode ^ text.hashCode ^ options.hashCode ^ unitId.hashCode ^ lessonId.hashCode;

  @override
  String toString() =>
      'Question(id: $id, text: $text, options: $options, unitId: $unitId, lessonId: $lessonId)';
}
