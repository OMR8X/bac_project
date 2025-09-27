import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/domain/usecases/delete_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_topics_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/mark_notifications_as_read_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_user_subscribed_topics_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/refresh_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/register_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/sync_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/unsubscribe_to_topic_usecase.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:bac_project/presentation/notifications/state/topics_management/notifications_topics_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/notifications/data/repositories/notifications_repository_implements.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_database_datasource.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/get_device_token_usecase.dart';

Future<void> notificationsFeatureInjection() async {
  ///
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin());

  ///
  sl.registerLazySingleton<NotificationsDatabaseDatasource>(
    () => NotificationsDatabaseDatasourceImplements(apiManager: sl()),
  );

  sl.registerLazySingleton<NotificationsRemoteDatasource>(
    () => NotificationsRemoteDatasourceImplements(),
  );

  ///
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImplements(
      sl<NotificationsRemoteDatasource>(),
      sl<NotificationsDatabaseDatasource>(),
    ),
  );

  ///
  sl.registerFactory<InitializeNotificationsUsecase>(
    () => InitializeNotificationsUsecase(repository: sl()),
  );
  sl.registerFactory<GetDeviceTokenUsecase>(() => GetDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<DisplayNotificationUsecase>(
    () => DisplayNotificationUsecase(repository: sl()),
  );
  sl.registerFactory<SubscribeToTopicUsecase>(() => SubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<UnsubscribeToTopicUsecase>(() => UnsubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<GetNotificationsUsecase>(() => GetNotificationsUsecase(repository: sl()));
  sl.registerFactory<RefreshDeviceTokenUsecase>(() => RefreshDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<DeleteDeviceTokenUsecase>(() => DeleteDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<RegisterDeviceTokenUsecase>(
    () => RegisterDeviceTokenUsecase(repository: sl()),
  );

  // New status management use cases
  sl.registerFactory<MarkNotificationsAsReadUsecase>(
    () => MarkNotificationsAsReadUsecase(repository: sl()),
  );
  sl.registerFactory<GetUserSubscribedTopicsUsecase>(
    () => GetUserSubscribedTopicsUsecase(repository: sl()),
  );
  sl.registerFactory<GetNotificationsTopicsUsecase>(
    () => GetNotificationsTopicsUsecase(repository: sl()),
  );
  sl.registerFactory<SyncNotificationsUsecase>(
    () => SyncNotificationsUsecase(repository: sl()),
  );
}
