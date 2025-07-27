class Lesson {
  final String id;
  final String title;
  final int? questionsLength;
  final String unitId;

  const Lesson({
    required this.id,
    required this.title,
    required this.questionsLength,
    required this.unitId,
  });

  Lesson copyWith({String? id, String? title, int? questionsLength, String? unitId}) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      questionsLength: questionsLength ?? this.questionsLength,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson &&
        other.id == id &&
        other.title == title &&
        other.questionsLength == questionsLength &&
        other.unitId == unitId;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ questionsLength.hashCode ^ unitId.hashCode;

  @override
  String toString() =>
      'Lesson(id: $id, title: $title, questionsLength: $questionsLength, unitId: $unitId)';
}
