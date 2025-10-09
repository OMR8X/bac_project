import '../../../../core/services/logs/logger.dart';
import '../../domain/entities/notification_action.dart';
import '../../domain/enums/notification_action_type.dart';
import '../../domain/services/http_action_handler.dart';
import '../../domain/services/screen_action_handler.dart';

/// Service that orchestrates notification action handling
class NotificationActionService {
  final HttpActionHandler _httpActionHandler;
  final ScreenActionHandler _screenActionHandler;

  NotificationActionService({
    required HttpActionHandler httpActionHandler,
    required ScreenActionHandler screenActionHandler,
  }) : _httpActionHandler = httpActionHandler,
       _screenActionHandler = screenActionHandler;

  /// Execute a notification action based on its type
  Future<void> executeAction(NotificationAction action) async {
    ///
    Logger.message('Executing notification action: ${action.type} - ${action.uri}');

    ///
    try {
      switch (action.type) {
        case NotificationActionType.http:
          await _httpActionHandler.execute(action);
          break;
        case NotificationActionType.screen:
          await _screenActionHandler.execute(action);
          break;
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to execute action ${action.type}: ${action.uri}',
        stackTrace: stackTrace,
      );
      // Continue execution - don't let one failed action block others
    }
  }

  /// Execute multiple actions (useful for batch processing)
  Future<void> executeActions(List<NotificationAction> actions) async {
    for (final action in actions) {
      await executeAction(action);
    }
  }
}
