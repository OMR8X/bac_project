import 'package:equatable/equatable.dart';

class NotificationType extends Equatable {
  final int id;
  final String name;
  final String? description;

  const NotificationType({required this.id, required this.name, this.description});

  factory NotificationType.empty() {
    return const NotificationType(id: 0, name: '');
  }

  NotificationType copyWith({int? id, String? name, String? description}) {
    return NotificationType(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory NotificationType.fromJson(Map<String, dynamic> json) {
    return NotificationType(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}
