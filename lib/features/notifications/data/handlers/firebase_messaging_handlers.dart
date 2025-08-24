import 'package:bac_project/features/notifications/domain/usecases/display_firebase_notification_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../presentation/notifications/state/explore_notifications/notifications_bloc.dart';

///
/// [firebase messaging background handler]
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
    'A background message was received in flutter_background_service plugin: ${message.messageId}',
  );

  ///
  await Firebase.initializeApp(/*options: DefaultFirebaseOptions.currentPlatform*/);

  debugPrint('Firebase initialized');

  ///
  await ServiceLocator.init();

  debugPrint('ServiceLocator initialized');

  ///
  await sl<DisplayFirebaseNotificationUsecase>().call(message: message);

  debugPrint('DisplayFirebaseNotificationUsecase called');
}

///
/// [notifications action handler]
@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  if (response == null) {
    return;
  }
  return;
}

///
/// [firebase messaging foreground handler]
void onData(RemoteMessage message) async {
  debugPrint(
    'A foreground message was received in flutter_background_service plugin: ${message.messageId}',
  );
  await sl<DisplayFirebaseNotificationUsecase>().call(message: message);
  debugPrint('DisplayFirebaseNotificationUsecase called');
  sl<ExploreNotificationsBloc>().add(LoadExploreNotificationsEvent());
}

///
void onTokenRefreshed(String newToken) async {}

///
void onDone() {}

///
void onError(error) {}
