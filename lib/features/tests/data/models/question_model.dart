import 'package:bac_project/features/tests/data/mappers/option_mapper.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';

import '../../domain/entities/question.dart';
import '../../domain/entities/option.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.content,
    required super.options,
    super.unitId,
    required super.lessonId,
    super.imageUrl,
    super.categoryId,
    super.isMCQ,
    super.explain,
    super.questionAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      content: json['content'] as String,
      options:
          (json['options'] as List<dynamic>?)?.map((option) {
            return OptionModel.fromJson(option as Map<String, dynamic>).toEntity();
          }).toList() ??
          [],
      unitId: json['unit_id'] as int?,
      lessonId: json['lesson_id'] as int,
      imageUrl: (json['image_url'] as String?),
      categoryId: json['category_id'] as int?,
      isMCQ: json['is_mcq'] as bool?,
      explain: json['explain'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'options': options.map((option) => option.toModel().toJson()).toList() ?? [],
      'unit_id': unitId,
      'lesson_id': lessonId,
      'image': imageUrl,
      'category_id': categoryId,
      'is_mcq': isMCQ,
      'explain': explain,
    };
  }

  @override
  QuestionModel copyWith({
    int? id,
    String? content,
    List<Option>? options,
    int? unitId,
    int? lessonId,
    String? imageUrl,
    int? categoryId,
    bool? isMCQ,
    String? explain,
    List<QuestionAnswer>? questionAnswers,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      content: content ?? this.content,
      options: options ?? this.options,
      unitId: unitId ?? this.unitId,
      lessonId: lessonId ?? this.lessonId,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      isMCQ: isMCQ ?? this.isMCQ,
      explain: explain ?? this.explain,
      questionAnswers: questionAnswers ?? this.questionAnswers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuestionModel &&
        other.id == id &&
        other.content == content &&
        other.options == options &&
        other.unitId == unitId &&
        other.lessonId == lessonId &&
        other.imageUrl == imageUrl &&
        other.categoryId == categoryId &&
        other.isMCQ == isMCQ &&
        other.explain == explain;
  }

  @override
  int get hashCode =>
      id.hashCode ^ content.hashCode ^ options.hashCode ^ unitId.hashCode ^ lessonId.hashCode;

  @override
  String toString() =>
      'QuestionModel(id: $id, content: $content, options: $options, unitId: $unitId, lessonId: $lessonId)';
}
