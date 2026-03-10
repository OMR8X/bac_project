import '../models/result_model.dart';
import 'package:neuro_app/features/results/domain/entities/result.dart';

extension ResultModelExtension on ResultModel {
  Result get toEntity {
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
      questionAnswers: questionAnswers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ResultEntityExtension on Result {
  ResultModel get toModel {
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
      questionAnswers: questionAnswers,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
