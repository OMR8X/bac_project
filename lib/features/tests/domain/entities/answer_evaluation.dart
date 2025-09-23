class AnswerEvaluation {
  final int id;
  final int questionAnswerId;
  final bool isCorrect;
  final double? confidence;
  final String? notes;
  final String? modelName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AnswerEvaluation({
    required this.id,
    required this.questionAnswerId,
    required this.isCorrect,
    this.confidence,
    this.notes,
    this.modelName,
    this.createdAt,
    this.updatedAt,
  });

  AnswerEvaluation copyWith({
    int? id,
    int? questionAnswerId,
    bool? isCorrect,
    double? confidence,
    String? notes,
    String? modelName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AnswerEvaluation(
      id: id ?? this.id,
      questionAnswerId: questionAnswerId ?? this.questionAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
      confidence: confidence ?? this.confidence,
      notes: notes ?? this.notes,
      modelName: modelName ?? this.modelName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnswerEvaluation &&
        other.id == id &&
        other.questionAnswerId == questionAnswerId &&
        other.isCorrect == isCorrect &&
        other.confidence == confidence &&
        other.notes == notes &&
        other.modelName == modelName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      questionAnswerId.hashCode ^
      isCorrect.hashCode ^
      confidence.hashCode ^
      notes.hashCode ^
      modelName.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() =>
      'AnswerEvaluation(id: $id, questionAnswerId: $questionAnswerId, isCorrect: $isCorrect, confidence: $confidence, notes: $notes, modelName: $modelName, createdAt: $createdAt, updatedAt: $updatedAt)';
}
