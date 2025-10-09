import 'dart:convert';

import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/features/notifications/data/services/notification_action_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/entities/notification_action.dart';
import '../models/notification_action_model.dart';

@pragma('vm:entry-point')
Future<void> handleNotificationActions(NotificationResponse? response) async {
  Logger.message("=== NOTIFICATION ACTIONS HANDLER START ===");

  try {
    // Validate response payload
    if (response?.payload == null) {
      Logger.warning("Notification response payload is null");
      return;
    }

    // Parse payload
    final payload = jsonDecode(response!.payload!);
    if (payload["actions"] == null) {
      Logger.warning("No actions found in notification payload");
      return;
    }

    // Parse actions from payload
    final jsonActions = payload["actions"] as List<dynamic>;
    final List<NotificationAction> actions =
        jsonActions
            .map<NotificationAction>(
              (actionJson) => NotificationActionModel.fromJson(actionJson as Map<String, dynamic>),
            )
            .toList();

    // Find the matching action
    final action = actions.firstWhereOrNull((action) => action.actionId == response.actionId);

    if (action == null) {
      Logger.warning("Unknown action id: ${response.actionId}");
      return;
    }

    // Execute action using the service
    await sl<NotificationActionService>().executeAction(action);
    Logger.message("Notification action executed successfully: ${action.type} - ${action.uri}");
  } catch (e, stackTrace) {
    Logger.error(
      'Error handling notification action: $e',
      stackTrace: stackTrace,
    );
  }
}
