import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final int id;
  final String title;
  final int unitId;
  final int questionsCount;
  final String? iconUrl;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Lesson({
    required this.id,
    required this.title,
    required this.unitId,
    required this.questionsCount,
    this.iconUrl,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  Lesson copyWith({
    int? id,
    String? title,
    int? unitId,
    int? questionsCount,
    String? iconUrl,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      unitId: unitId ?? this.unitId,
      questionsCount: questionsCount ?? this.questionsCount,
      iconUrl: iconUrl ?? this.iconUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Lesson.mock() {
    return Lesson(
      id: 1,
      title: 'Sample Lesson',
      unitId: 1,
      questionsCount: 10,
      iconUrl: 'book',
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    unitId,
    questionsCount,
    iconUrl,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}
