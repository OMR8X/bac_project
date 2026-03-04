import 'codepush_client.dart';

class CodePushManager {
  final CodePushClient _codePushClient;

  CodePushManager(this._codePushClient);

  Future<void> init() async {
    await _codePushClient.initialize();
  }

  CodePushClient call() {
    return _codePushClient;
  }
}
