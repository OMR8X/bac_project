// Combined small response types for remote subscribe/unsubscribe
import 'package:dartz/dartz.dart';

class RemoteSubscribeResponse {
  final Unit result;
  RemoteSubscribeResponse(this.result);
}

class RemoteUnsubscribeResponse {
  final Unit result;
  RemoteUnsubscribeResponse(this.result);
}
