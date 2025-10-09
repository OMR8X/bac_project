import '../../../../core/services/logs/logger.dart';
import '../entities/notification_action.dart';

/// Abstract base class for handling notification actions
abstract class NotificationActionHandler {
  /// Execute the notification action
  Future<void> execute(NotificationAction action);

  /// Handle execution errors gracefully
  void handleError(String actionType, String uri, Object error) {
    Logger.warning('😳 general Notification action error ');
  }
}
