import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
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

  factory Lesson.mock() {
    return const Lesson(
      id: 1,
      title: 'Sample Lesson',
      unitId: 1,
      questionsCount: 10,
    );
  }

  @override
  List<Object?> get props => [id, title, unitId, questionsCount];
}
