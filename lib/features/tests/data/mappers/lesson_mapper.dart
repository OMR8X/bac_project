import '../models/lesson_model.dart';
import '../../domain/entities/lesson.dart';

extension LessonModelExtension on LessonModel {
  Lesson toEntity() {
    return Lesson(
      id: id,
      title: title,
      unitId: unitId,
      questionsCount: questionsCount,
    );
  }
}

extension LessonEntityExtension on Lesson {
  LessonModel toModel() {
    return LessonModel(
      id: id,
      title: title,
      unitId: unitId,
      questionsCount: questionsCount,
    );
  }
}
