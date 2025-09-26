import 'package:equatable/equatable.dart';

class UserNotification extends Equatable {
  final int id;
  final String userId;
  final int notificationId;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final DateTime? dismissedAt;
  final bool actionPerformed;

  const UserNotification({
    required this.id,
    required this.userId,
    required this.notificationId,
    this.deliveredAt,
    this.readAt,
    this.dismissedAt,
    this.actionPerformed = false,
  });

  factory UserNotification.empty() {
    return UserNotification(id: 0, userId: '', notificationId: 0);
  }

  UserNotification copyWith({
    int? id,
    String? userId,
    int? notificationId,
    DateTime? deliveredAt,
    DateTime? readAt,
    DateTime? dismissedAt,
    bool? actionPerformed,
  }) {
    return UserNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      notificationId: notificationId ?? this.notificationId,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
      actionPerformed: actionPerformed ?? this.actionPerformed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'notification_id': notificationId,
      'delivered_at': deliveredAt?.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
      'dismissed_at': dismissedAt?.toIso8601String(),
      'action_performed': actionPerformed,
    };
  }

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      notificationId: json['notification_id'] as int,
      deliveredAt: json['delivered_at'] != null ? DateTime.parse(json['delivered_at']) : null,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      dismissedAt: json['dismissed_at'] != null ? DateTime.parse(json['dismissed_at']) : null,
      actionPerformed: json['action_performed'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    notificationId,
    deliveredAt,
    readAt,
    dismissedAt,
    actionPerformed,
  ];
}
