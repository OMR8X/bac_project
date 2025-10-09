import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:bac_project/core/services/router/app_router.dart';
import 'package:bac_project/core/widgets/messages/snackbars/alert_snackbar_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/router/routes.dart';
import '../../../../features/notifications/domain/usecases/sync_notifications_usecase.dart';
import '../../../../features/notifications/domain/usecases/mark_notifications_as_read_usecase.dart';
import '../../../../features/notifications/domain/requests/mark_notifications_as_read_request.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<ExploreNotificationsEvent, ExploreNotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;
  final SyncNotificationsUsecase _syncNotificationsUsecase;
  final MarkNotificationsAsReadUsecase _markNotificationsAsReadUsecase;

  NotificationsBloc(
    this._getNotificationsUsecase,
    this._syncNotificationsUsecase,
    this._markNotificationsAsReadUsecase,
  ) : super(const ExploreNotificationsState()) {
    on<LoadNotificationsEvent>(onLoadNotificationsEvent);
    on<LoadMoreNotificationsEvent>(onLoadMoreNotificationsEvent);
    on<RefreshNotificationsEvent>(onRefreshNotificationsEvent);
    on<SyncNotificationsEvent>(onSyncNotificationsEvent);
    on<DisplayForegroundNotificationsEvent>(onDisplayForegroundNotificationsEvent);
    on<MarkNotificationsAsReadEvent>(onMarkNotificationsAsReadEvent);
  }

  onLoadNotificationsEvent(LoadNotificationsEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        status: NotificationsStatus.loading,
        currentOffset: 0,
        hasMoreData: true,
      ),
    );

    final response = await _getNotificationsUsecase.call(
      GetNotificationsRequest(
        limit: state.pageSize,
        offset: 0,
      ),
    );

    response.fold(
      (failure) {
        emit(state.copyWith(status: NotificationsStatus.failure, failure: failure));
      },
      (response) {
        final hasMoreData = response.notifications.length == state.pageSize;
        emit(
          state.copyWith(
            status: NotificationsStatus.success,
            notifications: response.notifications,
            failure: null,
            currentOffset: state.pageSize,
            hasMoreData: hasMoreData,
          ),
        );
      },
    );
  }

  onLoadMoreNotificationsEvent(
    LoadMoreNotificationsEvent event,
    Emitter<ExploreNotificationsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreData) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    if (kDebugMode) {
      await Future.delayed(Duration(milliseconds: 1000));
    }

    final response = await _getNotificationsUsecase.call(
      GetNotificationsRequest(
        limit: state.pageSize,
        offset: state.currentOffset,
      ),
    );

    response.fold(
      (failure) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (response) {
        final newNotifications = [...state.notifications, ...response.notifications];
        final hasMoreData = response.notifications.length == state.pageSize;

        emit(
          state.copyWith(
            notifications: newNotifications,
            isLoadingMore: false,
            currentOffset: state.currentOffset + state.pageSize,
            hasMoreData: hasMoreData,
          ),
        );
      },
    );
  }

  onRefreshNotificationsEvent(
    RefreshNotificationsEvent event,
    Emitter<ExploreNotificationsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: NotificationsStatus.loading,
        currentOffset: 0,
        hasMoreData: true,
      ),
    );

    final response = await _getNotificationsUsecase.call(
      GetNotificationsRequest(
        limit: state.pageSize,
        offset: 0,
      ),
    );

    response.fold(
      (failure) {
        emit(state.copyWith(status: NotificationsStatus.failure, failure: failure));
      },
      (response) {
        final hasMoreData = response.notifications.length == state.pageSize;
        emit(
          state.copyWith(
            status: NotificationsStatus.success,
            notifications: response.notifications,
            failure: null,
            currentOffset: state.pageSize,
            hasMoreData: hasMoreData,
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
      if (fullPath?.contains(Routes.quizzing.name) ?? false) {
        return;
      }
      if (fullPath?.contains(Routes.notifications.name) ?? false) {
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

  Future<void> onMarkNotificationsAsReadEvent(
    MarkNotificationsAsReadEvent event,
    Emitter<ExploreNotificationsState> emit,
  ) async {
    // Filter out notification IDs that are already marked as read
    final unreadIds =
        event.notificationIds.where((id) => !state.readNotificationIds.contains(id)).toList();

    // If all IDs are already marked as read, do nothing
    if (unreadIds.isEmpty) {
      return;
    }

    // Call the use case to mark notifications as read
    final result = await _markNotificationsAsReadUsecase.call(
      MarkNotificationsAsReadRequest(notificationIds: unreadIds),
    );

    // Only update state if the use case succeeded
    result.fold(
      (failure) {
        Logger.warning(failure.message, stackTrace: StackTrace.current);
      },
      (_) {
        // Update the tracking set with the new read IDs
        // final updatedReadIds =
        Set<String>.from(state.readNotificationIds)..addAll(unreadIds);
        // emit(state.copyWith(readNotificationIds: updatedReadIds));
      },
    );
  }
}
