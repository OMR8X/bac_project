import 'package:equatable/equatable.dart';
import '../enums/notification_priority.dart';

class Notification extends Equatable {
  final int id;
  final int typeId;
  final int topicId;
  final String title;
  final String body;
  final String? imageUrl;
  final String? actionType;
  final String? actionValue;
  final Map<String, dynamic>? payload;
  final NotificationPriority priority;
  final DateTime createdAt;
  final DateTime? expiresAt;

  const Notification({
    required this.id,
    required this.typeId,
    required this.topicId,
    required this.title,
    required this.body,
    this.imageUrl,
    this.actionType,
    this.actionValue,
    this.payload,
    this.priority = NotificationPriority.normal,
    required this.createdAt,
    this.expiresAt,
  });

  factory Notification.empty() {
    return Notification(
      id: 0,
      typeId: 0,
      topicId: 0,
      title: '',
      body: '',
      createdAt: DateTime.now(),
    );
  }

  Notification copyWith({
    int? id,
    int? typeId,
    int? topicId,
    String? title,
    String? body,
    String? imageUrl,
    String? actionType,
    String? actionValue,
    Map<String, dynamic>? payload,
    NotificationPriority? priority,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return Notification(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      topicId: topicId ?? this.topicId,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      actionType: actionType ?? this.actionType,
      actionValue: actionValue ?? this.actionValue,
      payload: payload ?? this.payload,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_id': typeId,
      'topic_id': topicId,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'action_type': actionType,
      'action_value': actionValue,
      'payload': payload,
      'priority': priority.value,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as int,
      typeId: json['type_id'] as int,
      topicId: json['topic_id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image_url'] as String?,
      actionType: json['action_type'] as String?,
      actionValue: json['action_value'] as String?,
      payload: json['payload'] as Map<String, dynamic>?,
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    typeId,
    topicId,
    title,
    body,
    imageUrl,
    actionType,
    actionValue,
    payload,
    priority,
    createdAt,
    expiresAt,
  ];
}
