import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:collection/collection.dart';

class Question {
  //
  final int id;
  final String content;
  //
  final int? unitId;
  final int lessonId;
  final String? imageUrl;
  //
  final List<Option> options;

  final int? categoryId;

  final bool? isMCQ;

  final String? explain;

  const Question({
    required this.id,
    required this.content,
    required this.options,
    this.unitId,
    required this.lessonId,
    this.imageUrl,
    this.categoryId,
    this.isMCQ,
    this.explain,
  });

  bool? trueAnswer(int answerId) {
    return options.firstWhereOrNull((option) => option.isCorrect ?? false)?.id == answerId;
  }

  Question copyWith({
    int? id,
    String? content,
    List<Option>? options,
    int? unitId,
    int? lessonId,
    String? imageUrl,
    int? categoryId,
    bool? isMCQ,
    String? explain,
  }) {
    return Question(
      id: id ?? this.id,
      content: content ?? this.content,
      options: options ?? this.options,
      unitId: unitId ?? this.unitId,
      lessonId: lessonId ?? this.lessonId,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      isMCQ: isMCQ ?? this.isMCQ,
      explain: explain ?? this.explain,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Question &&
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
      id.hashCode ^
      content.hashCode ^
      options.hashCode ^
      unitId.hashCode ^
      lessonId.hashCode ^
      (imageUrl?.hashCode ?? 0) ^
      (categoryId?.hashCode ?? 0) ^
      (isMCQ?.hashCode ?? 0) ^
      (explain?.hashCode ?? 0);

  @override
  String toString() =>
      'Question(id: $id, content: $content, options: $options, unitId: $unitId, lessonId: $lessonId, imageUrl: $imageUrl, categoryId: $categoryId, isMCQ: $isMCQ, explain: $explain)';

  static Question empty() {
    return Question(id: 0, content: '', options: [], lessonId: 0, imageUrl: null, categoryId: null, isMCQ: null, explain: null);
  }
}
