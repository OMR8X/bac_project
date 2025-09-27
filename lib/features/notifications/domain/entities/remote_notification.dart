import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/services/logs/logger.dart';
import '../enums/notification_status.dart';
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
  final String status; // 'unread', 'read', 'deleted'
  final bool isStarred;
  final DateTime? readAt;

  // Computed property for backward compatibility
  bool get seen => status == 'read';

  bool isValid() {
    return title.trim().isNotEmpty &&
        body.trim().isNotEmpty &&
        NotificationStatus.isValid(status) &&
        id > 0;
  }

  // Validation helpers
  static int validateAndSanitizeId(int id) {
    if (id <= 0) {
      sl<Logger>().logError('Notification ID must be positive: $id');
      throw ArgumentError('Notification ID must be positive');
    }
    return id;
  }

  static String validateAndSanitizeTitle(String title) {
    final sanitized = title.trim();
    if (sanitized.isEmpty) {
      sl<Logger>().logError('Notification title cannot be empty: $title');
      throw ArgumentError('Notification title cannot be empty');
    }
    return sanitized;
  }

  static String validateAndSanitizeBody(String body) {
    final sanitized = body.trim();
    if (sanitized.isEmpty) {
      sl<Logger>().logError('Notification body cannot be empty: $body');
      throw ArgumentError('Notification body cannot be empty');
    }
    return sanitized;
  }

  static String validateStatus(String status) {
    if (!NotificationStatus.isValid(status)) {
      sl<Logger>().logError('Invalid notification status: $status');
      throw ArgumentError('Invalid notification status: $status');
    }
    return status;
  }

  AppNotification copyWith({
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
    String? status,
    bool? isStarred,
    DateTime? readAt,
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
      status: status ?? this.status,
      isStarred: isStarred ?? this.isStarred,
      readAt: readAt ?? this.readAt,
    );
  }

  factory AppNotification.fromRemoteMessage(RemoteMessage message) {
    DateTime createdAt = DateTime.now();
    if (message.data["date"] != null) {
      try {
        createdAt = DateTime.parse(message.data["date"]);
      } catch (e) {
        sl<Logger>().logError('Error parsing date: $e');
        // Keep default date if parsing fails
        createdAt = DateTime.now();
      }
    }

    return AppNotification(
      id: int.tryParse(message.data['id']?.toString() ?? '0') ?? 0,
      topicId: int.tryParse(message.data['topic_id']?.toString() ?? '0') ?? 0,
      topicTitle: message.data['topic_title']?.toString(),
      title: message.data["title"] ?? message.notification?.title ?? '',
      body: message.data["body"] ?? message.notification?.body ?? '',
      imageUrl: message.data["image_url"],
      payload: Map<String, dynamic>.from(message.data["payload"] as Map<dynamic, dynamic>? ?? {}),
      priority: NotificationPriority.fromString(message.data["priority"] ?? 'normal'),
      createdAt: createdAt,
      expiresAt: null,
      status: 'unread',
      isStarred: false,
      readAt: null,
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
      status: 'unread',
      isStarred: false,
      readAt: null,
    );
  }

  AppNotification({
    required this.id,
    required this.topicId,
    this.topicTitle,
    required String title,
    required String body,
    this.imageUrl,
    this.payload,
    this.priority = NotificationPriority.normal,
    required this.createdAt,
    this.expiresAt,
    String status = 'unread',
    this.isStarred = false,
    this.readAt,
  }) : title = validateAndSanitizeTitle(title),
       body = validateAndSanitizeBody(body),
       status = validateStatus(status);

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
      'status': status,
      'is_starred': isStarred,
      'read_at': readAt?.toIso8601String(),
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    DateTime? readAt;
    if (json['read_at'] != null) {
      try {
        readAt = DateTime.parse(json['read_at']);
      } catch (e) {
        readAt = null;
      }
    }

    DateTime createdAt = DateTime.now();
    if (json['created_at'] != null) {
      try {
        createdAt = DateTime.parse(json['created_at']);
      } catch (e) {
        createdAt = DateTime.now();
      }
    }

    DateTime? expiresAt;
    if (json['expires_at'] != null) {
      try {
        expiresAt = DateTime.parse(json['expires_at']);
      } catch (e) {
        expiresAt = null;
      }
    }

    return AppNotification(
      id: json['id'] as int? ?? 0,
      topicId: json['topic_id'] as int? ?? 0,
      topicTitle: json['topic_title']?.toString(),
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
      payload: json['payload'] is Map ? Map<String, dynamic>.from(json['payload']) : null,
      priority: NotificationPriority.fromString(json['priority'] ?? 'normal'),
      createdAt: createdAt,
      expiresAt: expiresAt,
      status: json['status']?.toString() ?? 'unread',
      isStarred: json['is_starred'] == true,
      readAt: readAt,
    );
  }
}
