import 'package:firebase_messaging/firebase_messaging.dart';
import '../enums/notification_type.dart';
import '../enums/notification_status.dart';
import 'dart:math';

class AppNotification {
  final String id;
  final String title;
  final String? body;
  final String? html;
  final String? imageUrl;
  final String type; // 'direct', 'topic', 'broadcast'
  final String status; // 'unread', 'read', 'deleted'
  final bool isStarred;
  final DateTime? readAt;
  final String? fcmMessageId;
  final DateTime date;
  final Map<String, dynamic>? data;

  // Computed property for backward compatibility
  bool get seen => status == 'read';

  bool isValid() {
    return title.trim().isNotEmpty && NotificationType.isValid(type) && NotificationStatus.isValid(status) && id.trim().isNotEmpty;
  }

  // Validation helpers
  static String validateAndSanitizeId(String id) {
    final sanitized = id.trim();
    if (sanitized.isEmpty) {
      throw ArgumentError('Notification ID cannot be empty');
    }
    return sanitized;
  }

  static String validateAndSanitizeTitle(String title) {
    final sanitized = title.trim();
    if (sanitized.isEmpty) {
      throw ArgumentError('Notification title cannot be empty');
    }
    return sanitized;
  }

  static String validateType(String type) {
    if (!NotificationType.isValid(type)) {
      throw ArgumentError('Invalid notification type: $type');
    }
    return type;
  }

  static String validateStatus(String status) {
    if (!NotificationStatus.isValid(status)) {
      throw ArgumentError('Invalid notification status: $status');
    }
    return status;
  }

  // Generate unique ID with timestamp + random component
  static String _generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    return '${timestamp}_$random';
  }

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? html,
    String? imageUrl,
    String? type,
    String? status,
    bool? isStarred,
    DateTime? readAt,
    String? fcmMessageId,
    DateTime? date,
    Map<String, dynamic>? data,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      html: html ?? this.html,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      isStarred: isStarred ?? this.isStarred,
      readAt: readAt ?? this.readAt,
      fcmMessageId: fcmMessageId ?? this.fcmMessageId,
      date: date ?? this.date,
      data: data ?? this.data,
    );
  }

  factory AppNotification.fromRemoteMessage(RemoteMessage message) {
    DateTime date = DateTime.now();
    if (message.data["date"] != null) {
      try {
        date = DateTime.parse(message.data["date"]);
      } catch (e) {
        // Keep default date if parsing fails
        date = DateTime.now();
      }
    }

    return AppNotification(
      id: message.data['id'] ?? _generateUniqueId(),
      title: message.data["title"] ?? '',
      body: message.data["body"],
      html: message.data["html"],
      imageUrl: message.data["image_url"],
      type: message.data["type"] ?? 'direct',
      status: 'unread',
      isStarred: false,
      readAt: null,
      fcmMessageId: message.messageId,
      date: date,
      data: Map<String, dynamic>.from(message.data),
    );
  }

  factory AppNotification.empty() {
    return AppNotification(
      id: '',
      title: '',
      body: '',
      html: '',
      imageUrl: "",
      type: 'direct',
      status: 'unread',
      isStarred: false,
      readAt: null,
      fcmMessageId: null,
      date: DateTime.now(),
      data: null,
    );
  }

  AppNotification({
    required String id,
    required String title,
    this.body,
    this.html,
    this.imageUrl,
    required String type,
    String status = 'unread',
    this.isStarred = false,
    this.readAt,
    this.fcmMessageId,
    required this.date,
    this.data,
  }) : id = validateAndSanitizeId(id),
       title = validateAndSanitizeTitle(title),
       type = validateType(type),
       status = validateStatus(status);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'html': html,
      'type': type,
      'fcm_message_id': fcmMessageId,
      'created_at': date.toIso8601String(),
      'data': data,
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

    DateTime date = DateTime.now();
    if (json['created_at'] != null) {
      try {
        date = DateTime.parse(json['created_at']);
      } catch (e) {
        date = DateTime.now();
      }
    }

    return AppNotification(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString(),
      html: json['html']?.toString(),
      imageUrl: json['image_url']?.toString(),
      type: json['type']?.toString() ?? 'direct',
      status: json['status']?.toString() ?? 'unread',
      isStarred: json['is_starred'] == true,
      readAt: readAt,
      fcmMessageId: json['fcm_message_id']?.toString(),
      date: date,
      data: json['data'] is Map ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}
