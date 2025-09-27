import 'package:equatable/equatable.dart';
import '../enums/notification_priority.dart';

class Notification extends Equatable {
  final int id;
  final int topicId;
  final String? topicTitle;
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
    required this.topicId,
    this.topicTitle,
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
      topicId: 0,
      topicTitle: null,
      title: '',
      body: '',
      createdAt: DateTime.now(),
    );
  }

  Notification copyWith({
    int? id,
    int? topicId,
    String? topicTitle,
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
      topicId: topicId ?? this.topicId,
      topicTitle: topicTitle ?? this.topicTitle,
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
      'topic_id': topicId,
      'topic_title': topicTitle,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'payload': payload,
      'priority': priority.value,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as int,
      topicId: json['topic_id'] as int,
      topicTitle: json['topic_title'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['image_url'] as String?,
      payload: json['payload'] as Map<String, dynamic>?,
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    topicId,
    topicTitle,
    title,
    body,
    imageUrl,
    payload,
    priority,
    createdAt,
    expiresAt,
  ];
}
