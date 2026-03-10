import 'package:equatable/equatable.dart';

class AnswerEvaluation extends Equatable {
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
  List<Object?> get props => [
    id,
    questionAnswerId,
    isCorrect,
    confidence,
    notes,
    modelName,
    createdAt,
    updatedAt,
  ];
}
