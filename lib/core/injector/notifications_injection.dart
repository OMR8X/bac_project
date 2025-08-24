import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_local_datasource.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/domain/usecases/cancel_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/clear_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/create_notifications_channel_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/delete_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_firebase_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_local_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/refresh_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/unsubscribe_to_topic_usecase.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/notifications/data/repositories/notifications_repository_implements.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/display_firebase_notification_usecase.dart';
import '../../features/notifications/domain/usecases/get_device_token_usecase.dart';

Future<void> notificationsFeatureInjection() async {
  ///
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin());

  ///
  sl.registerLazySingleton<NotificationsLocalDatasource>(
    () => NotificationsLocalDatasourceImplements(sl<CacheManager>()),
  );
  sl.registerLazySingleton<NotificationsRemoteDatasource>(
    () => NotificationsRemoteDatasourceImplements(sl<ApiManager>()),
  );

  ///
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImplements(
      sl<NotificationsLocalDatasource>(),
      sl<NotificationsRemoteDatasource>(),
    ),
  );

  ///
  sl.registerFactory<InitializeFirebaseNotificationsUsecase>(
    () => InitializeFirebaseNotificationsUsecase(repository: sl()),
  );
  sl.registerFactory<InitializeLocalNotificationsUsecase>(
    () => InitializeLocalNotificationsUsecase(repository: sl()),
  );
  sl.registerFactory<DeleteNotificationUsecase>(() => DeleteNotificationUsecase(repository: sl()));
  sl.registerFactory<GetDeviceTokenUsecase>(() => GetDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<DisplayNotificationUsecase>(
    () => DisplayNotificationUsecase(repository: sl()),
  );
  sl.registerFactory<DisplayFirebaseNotificationUsecase>(
    () => DisplayFirebaseNotificationUsecase(repository: sl()),
  );
  sl.registerFactory<CancelNotificationUsecase>(() => CancelNotificationUsecase(repository: sl()));
  sl.registerFactory<CreateNotificationsChannelUsecase>(
    () => CreateNotificationsChannelUsecase(repository: sl()),
  );
  sl.registerFactory<SubscribeToTopicUsecase>(() => SubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<UnsubscribeToTopicUsecase>(() => UnsubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<GetNotificationsUsecase>(() => GetNotificationsUsecase(repository: sl()));
  sl.registerFactory<RefreshDeviceTokenUsecase>(() => RefreshDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<ClearNotificationsUsecase>(() => ClearNotificationsUsecase(repository: sl()));
  sl.registerFactory<DeleteDeviceTokenUsecase>(() => DeleteDeviceTokenUsecase(repository: sl()));

  ///
  await sl<InitializeLocalNotificationsUsecase>().call();
  await sl<InitializeFirebaseNotificationsUsecase>().call();
}
