part of 'notifications_bloc.dart';

sealed class ExploreNotificationsEvent extends Equatable {
  const ExploreNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class LoadExploreNotificationsEvent extends ExploreNotificationsEvent {
  const LoadExploreNotificationsEvent();

  @override
  List<Object> get props => [];
}

final class ClearExploreNotificationsEvent extends ExploreNotificationsEvent {
  const ClearExploreNotificationsEvent();

  @override
  List<Object> get props => [];
}
