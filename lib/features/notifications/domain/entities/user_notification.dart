import 'package:equatable/equatable.dart';

class UserNotification extends Equatable {
  final int id;
  final String userId;
  final int notificationId;
  final DateTime createdAt;
  final DateTime? readAt;

  const UserNotification({
    required this.id,
    required this.userId,
    required this.notificationId,
    required this.createdAt,
    this.readAt,
  });

  factory UserNotification.empty() {
    return UserNotification(id: 0, userId: '', notificationId: 0, createdAt: DateTime.now());
  }

  UserNotification copyWith({
    int? id,
    String? userId,
    int? notificationId,
    DateTime? createdAt,
    DateTime? readAt,
  }) {
    return UserNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      notificationId: notificationId ?? this.notificationId,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'notification_id': notificationId,
      'created_at': createdAt.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
    };
  }

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      notificationId: json['notification_id'] as int,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    notificationId,
    createdAt,
    readAt,
  ];
}
