import '../../domain/entities/answer_evaluation.dart';

class AnswerEvaluationModel extends AnswerEvaluation {
  const AnswerEvaluationModel({
    required super.id,
    required super.questionAnswerId,
    required super.isCorrect,
    super.confidence,
    super.notes,
    super.modelName,
    super.createdAt,
    super.updatedAt,
  });

  factory AnswerEvaluationModel.fromJson(Map<String, dynamic> json) {
    return AnswerEvaluationModel(
      id: json['id'] as int,
      questionAnswerId: json['question_answer_id'] as int,
      isCorrect: json['is_correct'] as bool,
      confidence: json['confidence'] != null ? (json['confidence'] as num).toDouble() : null,
      notes: json['notes'] as String?,
      modelName: json['model_name'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_answer_id': questionAnswerId,
      'is_correct': isCorrect,
      'confidence': confidence,
      'notes': notes,
      'model_name': modelName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  AnswerEvaluationModel copyWith({
    int? id,
    int? questionAnswerId,
    bool? isCorrect,
    double? confidence,
    String? notes,
    String? modelName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AnswerEvaluationModel(
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
    return other is AnswerEvaluationModel &&
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
      'AnswerEvaluationModel(id: $id, questionAnswerId: $questionAnswerId, isCorrect: $isCorrect, confidence: $confidence, notes: $notes, modelName: $modelName, createdAt: $createdAt, updatedAt: $updatedAt)';
}
