import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';

extension ResultModelExtension on ResultModel {
  Result toEntity() {
    return Result(
      id: id,
      userId: userId,
      lessonId: lessonId,
      lessonTitle: lessonTitle,
      resultOrder: resultOrder,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      score: score,
      durationSeconds: durationSeconds,
      resultTestMode: resultTestMode,
      answers: answers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ResultEntityExtension on Result {
  ResultModel toModel() {
    return ResultModel(
      id: id,
      userId: userId,
      lessonId: lessonId,
      lessonTitle: lessonTitle,
      resultOrder: resultOrder,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      score: score,
      durationSeconds: durationSeconds,
      resultTestMode: resultTestMode,
      answers: answers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
