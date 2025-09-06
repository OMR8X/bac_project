import 'package:bac_project/core/injector/app_injection.dart';
// import 'package:bac_project/core/services/cache/cache_manager.dart'; // No longer needed
// import 'package:bac_project/features/notifications/data/datasources/notification_local_data_source.dart'; // No longer needed
import 'package:bac_project/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:bac_project/features/notifications/domain/usecases/create_notifications_channel_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/delete_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_firebase_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/initialize_local_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/mark_notification_seen.dart';
import 'package:bac_project/features/notifications/domain/usecases/mark_notification_as_read_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/mark_notification_as_unread_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/toggle_notification_star_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_user_subscribed_topics_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/refresh_device_token_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/unsubscribe_to_topic_usecase.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/notifications/data/repositories/notifications_repository_implements.dart';
import 'package:bac_project/features/notifications/data/datasources/notifications_database_datasource.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/display_firebase_notification_usecase.dart';
import '../../features/notifications/domain/usecases/get_device_token_usecase.dart';

Future<void> notificationsFeatureInjection() async {
  ///
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin());

  ///
  // sl.registerLazySingleton<NotificationsLocalDataSource>(() => NotificationsLocalDataSourceImplements(cacheManager: sl<CacheManager>())); // No longer needed
  sl.registerLazySingleton<NotificationsDatabaseDatasource>(() => NotificationsDatabaseDatasourceImplements());

  sl.registerLazySingleton<NotificationsRemoteDatasource>(
    () => NotificationsRemoteDatasourceImplements(supabaseDatasource: sl<NotificationsDatabaseDatasource>()),
  );

  ///
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImplements(sl<NotificationsRemoteDatasource>(), sl<NotificationsDatabaseDatasource>()),
  );

  ///
  sl.registerFactory<InitializeFirebaseNotificationsUsecase>(() => InitializeFirebaseNotificationsUsecase(repository: sl()));
  sl.registerFactory<InitializeLocalNotificationsUsecase>(() => InitializeLocalNotificationsUsecase(repository: sl()));
  sl.registerFactory<MarkNotificationSeen>(() => MarkNotificationSeen(repository: sl()));
  sl.registerFactory<GetDeviceTokenUsecase>(() => GetDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<DisplayNotificationUsecase>(() => DisplayNotificationUsecase(repository: sl()));
  sl.registerFactory<DisplayFirebaseNotificationUsecase>(() => DisplayFirebaseNotificationUsecase(repository: sl()));
  sl.registerFactory<CreateNotificationsChannelUsecase>(() => CreateNotificationsChannelUsecase(repository: sl()));
  sl.registerFactory<SubscribeToTopicUsecase>(() => SubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<UnsubscribeToTopicUsecase>(() => UnsubscribeToTopicUsecase(repository: sl()));
  sl.registerFactory<GetNotificationsUsecase>(() => GetNotificationsUsecase(repository: sl()));
  sl.registerFactory<RefreshDeviceTokenUsecase>(() => RefreshDeviceTokenUsecase(repository: sl()));
  sl.registerFactory<DeleteDeviceTokenUsecase>(() => DeleteDeviceTokenUsecase(repository: sl()));

  // New status management use cases
  sl.registerFactory<MarkNotificationAsReadUsecase>(() => MarkNotificationAsReadUsecase(repository: sl()));
  sl.registerFactory<MarkNotificationAsUnreadUsecase>(() => MarkNotificationAsUnreadUsecase(repository: sl()));
  sl.registerFactory<DeleteNotificationUsecase>(() => DeleteNotificationUsecase(repository: sl()));
  sl.registerFactory<ToggleNotificationStarUsecase>(() => ToggleNotificationStarUsecase(repository: sl()));
  sl.registerFactory<GetUserSubscribedTopicsUsecase>(() => GetUserSubscribedTopicsUsecase(repository: sl()));

  ///
  sl.registerLazySingleton<ExploreNotificationsBloc>(
    () => ExploreNotificationsBloc(sl<GetNotificationsUsecase>())..add(const LoadNotificationsEvent()),
  );
}
