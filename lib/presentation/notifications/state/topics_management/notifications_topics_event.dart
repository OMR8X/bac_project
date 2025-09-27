part of 'notifications_topics_bloc.dart';

sealed class NotificationsTopicsEvent extends Equatable {
  const NotificationsTopicsEvent();

  @override
  List<Object> get props => [];
}

final class LoadTopicsEvent extends NotificationsTopicsEvent {
  const LoadTopicsEvent();

  @override
  List<Object> get props => [];
}

final class SubscribeToTopicEvent extends NotificationsTopicsEvent {
  final NotificationsTopic topic;

  const SubscribeToTopicEvent({required this.topic});

  @override
  List<Object> get props => [topic];
}

final class UnsubscribeFromTopicEvent extends NotificationsTopicsEvent {
  final NotificationsTopic topic;

  const UnsubscribeFromTopicEvent({required this.topic});

  @override
  List<Object> get props => [topic];
}
