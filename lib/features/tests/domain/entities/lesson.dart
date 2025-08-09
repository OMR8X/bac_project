class Lesson {
  final int id;
  final String title;
  final int unitId;
  final int questionsCount;
  const Lesson({
    required this.id,
    required this.title,
    required this.unitId,
    required this.questionsCount,
  });

  Lesson copyWith({int? id, String? title, int? unitId, int? questionsCount}) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      unitId: unitId ?? this.unitId,
      questionsCount: questionsCount ?? this.questionsCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson &&
        other.id == id &&
        other.title == title &&
        other.unitId == unitId &&
        other.questionsCount == questionsCount;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ unitId.hashCode ^ questionsCount.hashCode;

  @override
  String toString() =>
      'Lesson(id: $id, title: $title, unitId: $unitId, questionsCount: $questionsCount)';
}
