import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class ExploreNotificationsBloc extends Bloc<ExploreNotificationsEvent, ExploreNotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;

  ExploreNotificationsBloc(this._getNotificationsUsecase) : super(const ExploreNotificationsState()) {
    on<LoadNotificationsEvent>(onLoadNotificationsEvent);
  }

  onLoadNotificationsEvent(LoadNotificationsEvent event, Emitter emit) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    final response = await _getNotificationsUsecase.call(GetNotificationsRequest());

    response.fold(
      (failure) {
        emit(state.copyWith(status: NotificationsStatus.failure, errorMessage: failure.message));
        Fluttertoast.showToast(msg: failure.message);
      },
      (response) {
        emit(state.copyWith(status: NotificationsStatus.success, notifications: response.notifications, errorMessage: null));
      },
    );
  }
}
