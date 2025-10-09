import 'notification_action_handler.dart';

/// Interface for handling screen navigation notification actions
abstract class ScreenActionHandler implements NotificationActionHandler {
  /// Navigate to screen using deep link URI
  @override
  Future<void> execute(action);
}
