import '../../domain/entities/unit.dart';

class UnitModel extends Unit {
  const UnitModel({
    required super.id,
    required super.title,
    required super.subtitle,
    super.lessonsCount,
    super.icon,
    super.createdAt,
    super.updatedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      lessonsCount: json['lessons_count'] as int?,
      icon: json['icon'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'lessons_count': lessonsCount,
      'icon': icon,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  UnitModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? lessonsCount,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UnitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnitModel &&
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
      'UnitModel(id: $id, title: $title, subtitle: $subtitle, lessonsCount: $lessonsCount, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt)';
}
