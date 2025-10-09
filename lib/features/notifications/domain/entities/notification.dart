import 'package:equatable/equatable.dart';
import '../enums/notification_priority.dart';

class Notification extends Equatable {
  final int id;
  final int topicId;
  final String? topicTitle;
  final String title;
  final String body;
  final String? imageUrl;
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
      payload: payload ?? this.payload,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
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

