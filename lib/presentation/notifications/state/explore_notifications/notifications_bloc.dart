import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/core/services/router/app_router.dart';
import 'package:bac_project/core/widgets/messages/snackbars/alert_snackbar_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/router/app_routes.dart';
import '../../../../features/notifications/domain/usecases/sync_notifications_usecase.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<ExploreNotificationsEvent, ExploreNotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;
  final SyncNotificationsUsecase _syncNotificationsUsecase;

  NotificationsBloc(this._getNotificationsUsecase, this._syncNotificationsUsecase)
    : super(const ExploreNotificationsState()) {
    on<LoadNotificationsEvent>(onLoadNotificationsEvent);
    on<SyncNotificationsEvent>(onSyncNotificationsEvent);
    on<DisplayForegroundNotificationsEvent>(onDisplayForegroundNotificationsEvent);
  }

  onLoadNotificationsEvent(LoadNotificationsEvent event, Emitter emit) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    final response = await _getNotificationsUsecase.call(GetNotificationsRequest());

    response.fold(
      (failure) {
        emit(state.copyWith(status: NotificationsStatus.failure, failure: failure));
      },
      (response) {
        emit(
          state.copyWith(
            status: NotificationsStatus.success,
            notifications: response.notifications,
            failure: null,
          ),
        );
      },
    );
  }

  onSyncNotificationsEvent(SyncNotificationsEvent event, Emitter emit) async {
    final result = await _syncNotificationsUsecase.call();
    result.fold(
      (failure) => Logger.error(failure.message),
      (_) {},
    );
  }

  onDisplayForegroundNotificationsEvent(
    DisplayForegroundNotificationsEvent event,
    Emitter emit,
  ) async {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null) {
      /// Don't show snackbar if user is currently quizzing or exploring notifications
      final fullPath = GoRouter.of(context).state.name;
      if (fullPath?.contains(AppRoutes.quizzing.name) ?? false) {
        return;
      }
      if (fullPath?.contains(AppRoutes.notifications.name) ?? false) {
        return;
      }
      final notification = AppNotification.fromRemoteMessage(event.message);
      showAlertSnackbar(
        context: context,
        title: notification.title,
        subtitle: notification.body,
      );
      return;
    }
  }
}
