import 'notification_action_handler.dart';

/// Interface for handling HTTP notification actions
abstract class HttpActionHandler implements NotificationActionHandler {
  /// Execute HTTP request silently without user feedback
  @override
  Future<void> execute(action);
}
