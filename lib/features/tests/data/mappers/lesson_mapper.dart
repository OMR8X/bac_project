import '../models/lesson_model.dart';
import '../../domain/entities/lesson.dart';

extension LessonModelExtension on LessonModel {
  Lesson toEntity() {
    return Lesson(
      id: id,
      title: title,
      questionsLength: questionsLength,
      unitId: unitId,
    );
  }
}

extension LessonEntityExtension on Lesson {
  LessonModel toModel() {
    return LessonModel(
      id: id,
      title: title,
      questionsLength: questionsLength,
      unitId: unitId,
    );
  }
}
