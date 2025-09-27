part of 'notifications_topics_bloc.dart';

enum NotificationsTopicsStatus { loading, loaded, failure }

final class NotificationsTopicsState extends Equatable {
  const NotificationsTopicsState({
    this.status = NotificationsTopicsStatus.loading,
    this.topics = const [],
    this.subscribedTopicIds = const [],
    this.failure,
  });

  final NotificationsTopicsStatus status;
  final List<NotificationsTopic> topics;
  final List<int> subscribedTopicIds;
  final Failure? failure;

  NotificationsTopicsState copyWith({
    NotificationsTopicsStatus? status,
    List<NotificationsTopic>? topics,
    List<int>? subscribedTopicIds,
    Failure? failure,
  }) {
    return NotificationsTopicsState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
      subscribedTopicIds: subscribedTopicIds ?? this.subscribedTopicIds,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, topics, subscribedTopicIds, failure];
}
