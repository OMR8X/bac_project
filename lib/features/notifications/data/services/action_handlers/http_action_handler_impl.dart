import 'package:bac_project/core/services/api/api_manager.dart';
import '../../../../../core/services/logs/logger.dart';
import '../../../domain/entities/notification_action.dart';
import '../../../domain/services/http_action_handler.dart';

/// Implementation of HTTP action handler that makes silent requests
class HttpActionHandlerImpl implements HttpActionHandler {
  final ApiManager _apiManager;

  HttpActionHandlerImpl(this._apiManager);

  @override
  Future<void> execute(NotificationAction action) async {
    Logger.message('Executing HTTP action: ${action.uri}');
    try {
      await _apiManager().post(action.uri);
      Logger.message('HTTP action completed successfully: ${action.uri}');
    } catch (e) {
      handleError(action.type.name, action.uri, e);
    }
  }

  @override
  void handleError(String actionType, String uri, Object error) {
    Logger.error('HTTP action error for $uri: $error');
  }
}
