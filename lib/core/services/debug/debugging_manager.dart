import 'package:bac_project/core/services/debug/debugging_client.dart';

class DebuggingManager {
  late final DebuggingClient _debuggingClient;

  ///
  Future<void> init() async {
    _debuggingClient = LoggerClient();
    _debuggingClient.initialize();
    return;
  }

  ///
  DebuggingClient call() {
    return _debuggingClient;
  }
}
