import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/usecases/clear_notifications_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class ExploreNotificationsBloc extends Bloc<ExploreNotificationsEvent, ExploreNotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;
  final ClearNotificationsUsecase _clearNotificationsUsecase;
  ExploreNotificationsBloc(this._getNotificationsUsecase, this._clearNotificationsUsecase)
    : super(ExploreNotificationsState()) {
    on<LoadExploreNotificationsEvent>(onLoadExploreNotificationsEvent);
    on<ClearExploreNotificationsEvent>(onClearExploreNotificationsEvent);
  }

  onLoadExploreNotificationsEvent(LoadExploreNotificationsEvent event, Emitter emit) async {
    //
    final response = await _getNotificationsUsecase.call();
    //
    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (notifications) {
        emit(ExploreNotificationsState(notifications: notifications));
      },
    );
  }

  onClearExploreNotificationsEvent(ClearExploreNotificationsEvent event, Emitter emit) async {
    //
    final response = await _clearNotificationsUsecase.call();
    //
    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (notifications) {
        emit(ExploreNotificationsState(notifications: []));
      },
    );
  }
}
