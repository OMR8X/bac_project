import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_category.dart';

class Question {
  //
  final int id;
  final String text;
  //
  final int? unitId;
  final int lessonId;
  //
  final List<Option> options;
  // Optional image URL or path
  final String? image;
  // Optional question category
  final QuestionCategory? category;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    this.unitId,
    required this.lessonId,
    this.image,
    this.category,
  });

  bool trueAnswers(int answerId) {
    return options.where((option) => option.isCorrect).any((option) => option.id == answerId);
  }

  Question copyWith({
    int? id,
    String? text,
    List<Option>? options,
    int? unitId,
    int? lessonId,
    String? image,
    QuestionCategory? category,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? this.options,
      unitId: unitId ?? this.unitId,
      lessonId: lessonId ?? this.lessonId,
      image: image ?? this.image,
      category: category ?? this.category,
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
        other.lessonId == lessonId &&
        other.image == image &&
        other.category == category;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      options.hashCode ^
      unitId.hashCode ^
      lessonId.hashCode ^
      (image?.hashCode ?? 0) ^
      (category?.hashCode ?? 0);

  @override
  String toString() =>
      'Question(id: $id, text: $text, options: $options, unitId: $unitId, lessonId: $lessonId, image: $image, category: $category)';

  static Question empty() {
    return Question(id: 0, text: '', options: [], lessonId: 0, image: null, category: null);
  }
}
