import 'package:skeletonizer/skeletonizer.dart';
import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  final int id;
  final String title;
  final String subtitle;
  final int? lessonsCount;
  final String? iconUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Unit({
    required this.id,
    required this.title,
    required this.subtitle,
    this.lessonsCount,
    this.iconUrl,
    this.createdAt,
    this.updatedAt,
  });

  Unit copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? lessonsCount,
    String? iconUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Unit(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      iconUrl: iconUrl ?? this.iconUrl,
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
      iconUrl: 'book',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    lessonsCount,
    iconUrl,
    createdAt,
    updatedAt,
  ];
}
