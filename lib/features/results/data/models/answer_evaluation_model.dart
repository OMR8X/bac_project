import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer_evaluation.dart';

part 'answer_evaluation_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory AnswerEvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerEvaluationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerEvaluationModelToJson(this);

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
}
