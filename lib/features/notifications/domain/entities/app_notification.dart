import 'dart:convert';

import 'package:bac_project/features/notifications/data/mappers/notification_entities_mapper.dart';
import 'package:bac_project/features/notifications/data/models/notification_action_model.dart';
import 'package:bac_project/features/notifications/domain/entities/notification_action.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/services/logs/logger.dart';
import '../enums/notification_priority.dart';

class AppNotification {
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
  final DateTime? readedAt;

  // Computed property for backward compatibility
  bool get seen => readedAt != null;

  // Computed status property derived from readedAt
  String get status => readedAt != null ? 'read' : 'unread';

  bool isValid() {
    return title.trim().isNotEmpty && body.trim().isNotEmpty;
  }

  List<NotificationAction> actions() {
    if (payload?['actions'] == null) return [];
    final actionsList = jsonDecode(jsonEncode(payload!['actions'])) as List<dynamic>;
    final actions =
        actionsList
            .map(
              (actionJson) =>
                  NotificationActionModel.fromJson(actionJson as Map<String, dynamic>).toEntity,
            )
            .toList();
    return actions;
  }

  factory AppNotification.fromRemoteMessage(RemoteMessage message) {
    DateTime createdAt = DateTime.now();
    if (message.data["date"] != null) {
      try {
        createdAt = DateTime.parse(message.data["date"]);
      } catch (e) {
        Logger.error('Error parsing date: $e');
        createdAt = DateTime.now();
      }
    }
    String title = message.data["title"] ?? message.notification?.title ?? '';
    String body = message.data["body"] ?? message.notification?.body ?? '';

    return AppNotification(
      id: int.tryParse(message.data['id']?.toString() ?? '0') ?? DateTime.now().millisecond,
      topicId: int.tryParse(message.data['topic_id']?.toString() ?? '0') ?? 0,
      topicTitle: message.data['topic_title']?.toString(),
      title: title,
      body: body,
      imageUrl: message.data["image_url"],
      payload: message.data,
      priority: NotificationPriority.fromString(message.data["priority"] ?? 'normal'),
      createdAt: createdAt,
      expiresAt: null,
      readedAt: null,
    );
  }

  factory AppNotification.empty() {
    return AppNotification(
      id: 0,
      topicId: 0,
      topicTitle: null,
      title: '',
      body: '',
      imageUrl: null,
      payload: null,
      priority: NotificationPriority.normal,
      createdAt: DateTime.now(),
      expiresAt: null,
      readedAt: null,
    );
  }

  factory AppNotification.mock() {
    return AppNotification(
      id: 0,
      topicId: 0,
      topicTitle: null,
      title: BoneMock.title,
      body: BoneMock.words(8),
      imageUrl: null,
      payload: null,
      priority: NotificationPriority.normal,
      createdAt: DateTime.now(),
      expiresAt: null,
      readedAt: DateTime.now(),
    );
  }

  AppNotification copyWith({
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
    DateTime? readedAt,
  }) {
    return AppNotification(
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
      readedAt: readedAt ?? this.readedAt,
    );
  }

  AppNotification({
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
    this.readedAt,
  });
}
