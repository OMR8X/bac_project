import '../models/answer_evaluation_model.dart';
import '../../domain/entities/answer_evaluation.dart';

extension AnswerEvaluationModelExtension on AnswerEvaluationModel {
  AnswerEvaluation toEntity() {
    return AnswerEvaluation(
      id: id,
      questionAnswerId: questionAnswerId,
      isCorrect: isCorrect,
      confidence: confidence,
      notes: notes,
      modelName: modelName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension AnswerEvaluationEntityExtension on AnswerEvaluation {
  AnswerEvaluationModel toModel() {
    return AnswerEvaluationModel(
      id: id,
      questionAnswerId: questionAnswerId,
      isCorrect: isCorrect,
      confidence: confidence,
      notes: notes,
      modelName: modelName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
