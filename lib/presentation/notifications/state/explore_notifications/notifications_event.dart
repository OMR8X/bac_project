part of 'notifications_bloc.dart';

sealed class ExploreNotificationsEvent extends Equatable {
  const ExploreNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class LoadNotificationsEvent extends ExploreNotificationsEvent {
  const LoadNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class StoreTokenEvent extends ExploreNotificationsEvent {
  final String? token;
  const StoreTokenEvent({this.token});

  @override
  List<Object> get props => [];
}
