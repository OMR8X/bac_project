import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppNotification {
  final int id;
  final String title;
  final String? subtitle;
  final String? html;
  final String? imageUrl;
  final DateTime date;
  final bool seen;

  bool valid() {
    return title.isNotEmpty;
  }

  AppNotification copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? html,
    String? imageUrl,
    DateTime? date,
    bool? seen,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      html: html ?? this.html,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      seen: seen ?? this.seen,
    );
  }

  factory AppNotification.fromRemoteMessage(RemoteMessage message) {
    DateTime date = DateTime.now();
    if (message.data["date"] != null) {
      date = DateTime.parse(message.data["date"]);
    }
    return AppNotification(
      id: DateTime.now().millisecond,
      title: message.data["title"] ?? '',
      subtitle: message.data["subtitle"],
      html: message.data["html"],
      imageUrl: message.data["image_url"],
      date: date,
    );
  }
  factory AppNotification.empty() {
    return AppNotification(
      id: 0,
      title: '',
      subtitle: '',
      html: '',
      imageUrl: '',
      date: DateTime.now(),
    );
  }

  AppNotification({
    required this.id,
    required this.title,
    this.subtitle,
    this.html,
    this.imageUrl,
    this.seen = false,
    required this.date,
  });
}
