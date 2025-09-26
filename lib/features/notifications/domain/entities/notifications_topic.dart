import 'package:equatable/equatable.dart';

class NotificationsTopic extends Equatable {
  final int id;
  final String name;
  final String? description;

  const NotificationsTopic({required this.id, required this.name, this.description});

  factory NotificationsTopic.empty() {
    return const NotificationsTopic(id: 0, name: '');
  }

  NotificationsTopic copyWith({int? id, String? name, String? description}) {
    return NotificationsTopic(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory NotificationsTopic.fromJson(Map<String, dynamic> json) {
    return NotificationsTopic(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}
