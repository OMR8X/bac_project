import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/injector/tests_feature_inj.dart';
import '../../../../features/notifications/domain/requests/register_device_token_request.dart';
import '../../../../features/notifications/domain/usecases/get_device_token_usecase.dart';
import '../../../../features/notifications/domain/usecases/register_device_token_usecase.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<ExploreNotificationsEvent, ExploreNotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;

  NotificationsBloc(this._getNotificationsUsecase) : super(const ExploreNotificationsState()) {
    on<LoadNotificationsEvent>(onLoadNotificationsEvent);
    on<StoreTokenEvent>(onStoreTokenEvent);
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
        emit(
          state.copyWith(
            status: NotificationsStatus.success,
            notifications: response.notifications,
            errorMessage: null,
          ),
        );
      },
    );
  }

  onStoreTokenEvent(StoreTokenEvent event, Emitter emit) async {
    ///
    String? token;

    ///
    if (event.token == null) {
      final response = await sl<GetDeviceTokenUsecase>().call();
      token = response.fold(
        (failure) => null,
        (response) => response,
      );
    }

    ///
    if (token == null) return;

    ///
    await sl<RegisterDeviceTokenUsecase>().call(
      await RegisterDeviceTokenRequest.fromDeviceToken(token),
    );
  }
}
