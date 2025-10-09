import 'package:skeletonizer/skeletonizer.dart';

class Unit {
  final int id;
  final String title;
  final String subtitle;
  final int? lessonsCount;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Unit({
    required this.id,
    required this.title,
    required this.subtitle,
    this.lessonsCount,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  Unit copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? lessonsCount,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Unit(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Unit.mock() {
    return Unit(
      id: 1,
      title: BoneMock.title,
      subtitle: BoneMock.words(3),
      lessonsCount: 5,
      icon: 'book',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Unit &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.lessonsCount == lessonsCount &&
        other.icon == icon &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      lessonsCount.hashCode ^
      icon.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() =>
      'Unit(id: $id, title: $title, subtitle: $subtitle, lessonsCount: $lessonsCount, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt)';
}
