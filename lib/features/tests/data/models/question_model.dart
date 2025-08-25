import 'package:bac_project/features/tests/data/mappers/option_mapper.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/data/models/question_category_model.dart';
import 'package:bac_project/features/tests/data/mappers/question_category_mapper.dart';

import '../../domain/entities/question.dart';
import '../../domain/entities/option.dart';
import '../../domain/entities/question_category.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.text,
    required super.options,
    super.unitId,
    required super.lessonId,
    super.image,
    super.category,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      text: json['text'] as String,
      options:
          (json['options'] as List<dynamic>).map((option) {
            return OptionModel.fromJson(option as Map<String, dynamic>).toEntity();
          }).toList(),
      unitId: json['unit_id'] as int?,
      lessonId: json['lesson_id'] as int,
      image: json['image'] as String?,
      category:
          json['category'] != null
              ? QuestionCategoryModel.fromJson(json['category'] as Map<String, dynamic>).toEntity()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((option) => option.toModel().toJson()).toList(),
      'unit_id': unitId,
      'lesson_id': lessonId,
      'image': image,
      'category': category?.toModel().toJson(),
    };
  }

  @override
  QuestionModel copyWith({
    int? id,
    String? text,
    List<Option>? options,
    int? unitId,
    int? lessonId,
    String? image,
    QuestionCategory? category,
  }) {
    return QuestionModel(
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
    return other is QuestionModel &&
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
      'QuestionModel(id: $id, text: $text, options: $options, unitId: $unitId, lessonId: $lessonId)';
}
