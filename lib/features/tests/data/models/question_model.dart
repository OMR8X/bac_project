import 'package:bac_project/features/tests/data/mappers/option_mapper.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';

import '../../domain/entities/question.dart';
import '../../domain/entities/option.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.text,
    required super.options,
    required super.category,
    super.unitId,
    super.lessonId,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      options:
          (json['options'] as List<dynamic>).map((option) {
            return OptionModel.fromJson(option as Map<String, dynamic>).toEntity();
          }).toList(),
      category: json['category'] as String? ?? '',
      unitId: json['unitId'] as String?,
      lessonId: json['lessonId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((option) => option.toModel().toJson()).toList(),
      'category': category,
      'unit_id': unitId,
      'lesson_id': lessonId,
    };
  }

  Question toEntity() {
    return Question(
      id: id,
      text: text,
      options: options.map((option) => option.toModel()).toList(),
      category: category,
      unitId: unitId,
      lessonId: lessonId,
    );
  }

  @override
  QuestionModel copyWith({
    String? id,
    String? text,
    List<Option>? options,
    String? category,
    String? unitId,
    String? lessonId,
  }) {
    return QuestionModel(
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
    return other is QuestionModel &&
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
      'QuestionModel(id: $id, text: $text, options: $options, category: $category, unitId: $unitId, lessonId: $lessonId)';
}
