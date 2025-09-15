import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/features/notifications/data/models/device_token_model.dart';
import 'package:bac_project/features/notifications/data/settings/firebase_messaging_settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/requests/get_notifications_request.dart';
import '../../domain/requests/register_device_token_request.dart';
import '../../domain/requests/update_notification_status_request.dart';
import '../../domain/requests/toggle_notification_star_request.dart';
import '../../domain/requests/subscribe_to_topic_request.dart';
import '../../domain/requests/unsubscribe_from_topic_request.dart';
import '../../domain/requests/get_user_subscribed_topics_request.dart';
import '../responses/get_notifications_response.dart';
import '../responses/register_device_token_response.dart';
import '../responses/update_notification_status_response.dart';
import '../responses/toggle_notification_star_response.dart';
import '../responses/subscribe_to_topic_response.dart';
import '../responses/unsubscribe_from_topic_response.dart';
import '../responses/get_user_subscribed_topics_response.dart';

abstract class NotificationsDatabaseDatasource {
  Future<RegisterDeviceTokenResponse> registerDeviceToken(RegisterDeviceTokenRequest request);
  Future<GetNotificationsResponse> getNotifications(GetNotificationsRequest request);
  Future<UpdateNotificationStatusResponse> updateNotificationStatus(
    UpdateNotificationStatusRequest request,
  );
  Future<ToggleNotificationStarResponse> toggleNotificationStar(
    ToggleNotificationStarRequest request,
  );
  Future<SubscribeToTopicResponse> subscribeToTopicInDatabase(SubscribeToTopicRequest request);
  Future<UnsubscribeFromTopicResponse> unsubscribeFromTopicInDatabase(
    UnsubscribeFromTopicRequest request,
  );
  Future<GetUserSubscribedTopicsResponse> getUserSubscribedTopics(
    GetUserSubscribedTopicsRequest request,
  );
}

class NotificationsDatabaseDatasourceImplements implements NotificationsDatabaseDatasource {
  final _supabase = Supabase.instance.client;

  @override
  Future<RegisterDeviceTokenResponse> registerDeviceToken(
    RegisterDeviceTokenRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    final model = DeviceTokenModel.create(
      userId: user!.id,
      deviceToken: request.deviceToken,
      platform: request.platform,
    );

    await _supabase
        .from('device_tokens')
        .delete()
        .eq('user_id', model.userId)
        .eq('platform', model.platform);

    await _supabase.from('device_tokens').insert(model.toMap());
    debugPrint("✅ Device token registered successfully to Supabase");
    return RegisterDeviceTokenResponse(unit);
  }

  @override
  Future<GetNotificationsResponse> getNotifications(GetNotificationsRequest request) async {
    final user = _supabase.auth.currentUser;
    final userId = user!.id;

    // Get user's subscribed topics
    final subscribedTopicsResponse = await getUserSubscribedTopics(
      GetUserSubscribedTopicsRequest(),
    );
    final subscribedTopics = subscribedTopicsResponse.topics;

    // For direct and broadcast notifications, get via user_notifications table
    final userNotificationsResponse =
        await _supabase
                .from('user_notifications')
                .select('''
          notification_id, status, is_starred, read_at, created_at, updated_at,
          notifications!inner(
            id, title, body, html, image_url, type, data, fcm_message_id, created_at
          )
        ''')
                .eq('user_id', userId)
                .neq('status', 'deleted')
                .order('notifications.created_at', ascending: false)
            as List;

    // Get topic notifications that user hasn't seen yet and create user_notifications entries
    List<Map<String, dynamic>> topicNotificationsForUser = [];
    if (subscribedTopics.isNotEmpty) {
      // Get topic notifications that are not yet in user_notifications
      final existingUserNotifications =
          await _supabase.from('user_notifications').select('notification_id').eq('user_id', userId)
              as List;

      final existingNotificationIds =
          existingUserNotifications.map((item) => item['notification_id'] as String).toSet();

      final topicNotificationsResponse =
          await _supabase
                  .from('notifications')
                  .select('*')
                  .eq('type', 'topic')
                  .order('created_at', ascending: false)
                  .limit(50)
              as List; // Limit to recent notifications

      // Create user_notifications entries for new topic notifications only
      for (final notification in topicNotificationsResponse) {
        final notificationId = notification['id'] as String;
        if (!existingNotificationIds.contains(notificationId)) {
          try {
            await _supabase.from('user_notifications').insert({
              'notification_id': notificationId,
              'user_id': userId,
              'status': 'unread',
              'is_starred': false,
            });

            // Add to our result set
            topicNotificationsForUser.add({
              'notification_id': notificationId,
              'status': 'unread',
              'is_starred': false,
              'read_at': null,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
              'notifications': notification,
            });
          } catch (e) {
            // Entry might already exist or other error, skip
          }
        }
      }
    }

    // Combine user notifications with topic notifications
    final allNotifications = [
      ...userNotificationsResponse.cast<Map<String, dynamic>>(),
      ...topicNotificationsForUser,
    ];

    // Sort by notification creation date
    allNotifications.sort((a, b) {
      final aDate = DateTime.parse(a['notifications']['created_at']);
      final bDate = DateTime.parse(b['notifications']['created_at']);
      return bDate.compareTo(aDate); // Descending order
    });

    final response = allNotifications;

    final notifications =
        response.map((item) {
          final userNotification = item;
          final notification = userNotification['notifications'] as Map<String, dynamic>;

          return AppNotification.fromJson({
            ...notification,
            'status': userNotification['status'],
            'is_starred': userNotification['is_starred'],
            'read_at': userNotification['read_at'],
          });
        }).toList();

    return GetNotificationsResponse(notifications: notifications);
  }

  @override
  Future<UpdateNotificationStatusResponse> updateNotificationStatus(
    UpdateNotificationStatusRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    final updateData = {'status': request.status, 'updated_at': DateTime.now().toIso8601String()};

    if (request.readAt != null) {
      updateData['read_at'] = request.readAt!.toIso8601String();
    }

    await _supabase
        .from('user_notifications')
        .update(updateData)
        .eq('notification_id', request.notificationId)
        .eq('user_id', user!.id);

    return UpdateNotificationStatusResponse(unit);
  }

  @override
  Future<ToggleNotificationStarResponse> toggleNotificationStar(
    ToggleNotificationStarRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    await _supabase
        .from('user_notifications')
        .update({'is_starred': request.isStarred, 'updated_at': DateTime.now().toIso8601String()})
        .eq('notification_id', request.notificationId)
        .eq('user_id', user!.id);

    return ToggleNotificationStarResponse(unit);
  }

  @override
  Future<SubscribeToTopicResponse> subscribeToTopicInDatabase(
    SubscribeToTopicRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    // We need FCM token; try to lookup from device_tokens table for this user and platform (if applicable)
    final tokenRecord =
        await _supabase
                .from('device_tokens')
                .select('device_token')
                .eq('user_id', user!.id)
                .limit(1)
            as List;
    final fcmToken = tokenRecord.isNotEmpty ? tokenRecord.first['device_token'] as String : '';

    await _supabase.from('topic_subscriptions').upsert({
      'user_id': user.id,
      'topic_title': request.topic,
      'fcm_token': fcmToken,
      'created_at': DateTime.now().toIso8601String(),
    });

    return SubscribeToTopicResponse(unit);
  }

  @override
  Future<UnsubscribeFromTopicResponse> unsubscribeFromTopicInDatabase(
    UnsubscribeFromTopicRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    await _supabase
        .from('topic_subscriptions')
        .delete()
        .eq('user_id', user!.id)
        .eq('topic_title', request.topic);

    return UnsubscribeFromTopicResponse(unit);
  }

  @override
  Future<GetUserSubscribedTopicsResponse> getUserSubscribedTopics(
    GetUserSubscribedTopicsRequest request,
  ) async {
    final user = _supabase.auth.currentUser;

    final response =
        await _supabase.from('topic_subscriptions').select('topic_title').eq('user_id', user!.id)
            as List;

    final subscribedTopics = response.map((item) => item['topic_title'] as String).toList();

    // Always include default topics
    final allTopics =
        {...AppRemoteNotificationsSettings.defaultTopicList, ...subscribedTopics}.toList();

    return GetUserSubscribedTopicsResponse(topics: allTopics);
  }
}
