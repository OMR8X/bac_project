import '../../../../../core/services/logs/logger.dart';
import '../../../../../core/services/router/app_router.dart';
import '../../../domain/entities/notification_action.dart';
import '../../../domain/services/screen_action_handler.dart';

/// Implementation of screen action handler that navigates using deep links
class ScreenActionHandlerImpl implements ScreenActionHandler {
  @override
  Future<void> execute(NotificationAction action) async {
    try {
      Logger.message('Executing screen action: ${action.uri}');

      // Use GoRouter to navigate to the screen
      AppRouter.router.go(action.uri);

      Logger.message('Screen navigation completed: ${action.uri}');
    } catch (e, stackTrace) {
      Logger.error(
        'Screen navigation failed: ${action.uri}',
        stackTrace: stackTrace,
      );
      // Handle navigation errors gracefully
    }
  }

  @override
  void handleError(String actionType, String uri, Object error) {
    Logger.error('Screen action error for $uri: $error');
  }
}
