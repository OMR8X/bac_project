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

final class DisplayForegroundNotificationsEvent extends ExploreNotificationsEvent {
  final RemoteMessage message;
  const DisplayForegroundNotificationsEvent({required this.message});

  @override
  List<Object> get props => [];
}

final class SyncNotificationsEvent extends ExploreNotificationsEvent {
  const SyncNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class MarkNotificationsAsReadEvent extends ExploreNotificationsEvent {
  final List<String> notificationIds;

  const MarkNotificationsAsReadEvent({required this.notificationIds});

  @override
  List<Object> get props => [notificationIds];
}

final class LoadMoreNotificationsEvent extends ExploreNotificationsEvent {
  const LoadMoreNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class RefreshNotificationsEvent extends ExploreNotificationsEvent {
  const RefreshNotificationsEvent();

  @override
  List<Object> get props => [];
}
