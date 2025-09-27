import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  }

  onLoadNotificationsEvent(LoadNotificationsEvent event, Emitter emit) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    final response = await _getNotificationsUsecase.call(GetNotificationsRequest());

    response.fold(
      (failure) {
        emit(state.copyWith(status: NotificationsStatus.failure, failure: failure));
        Fluttertoast.showToast(msg: failure.message);
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
      (failure) {
        // Handle failure if needed - could emit a state or show toast
        Fluttertoast.showToast(msg: 'Failed to sync notifications: ${failure.message}');
      },
      (_) {
        // Success - could emit a state or show success message
        Fluttertoast.showToast(msg: 'Notifications synced successfully');
      },
    );
  }
}
