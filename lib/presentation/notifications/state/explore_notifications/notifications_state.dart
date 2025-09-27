part of 'notifications_bloc.dart';

enum NotificationsStatus { loading, success, failure }

final class ExploreNotificationsState extends Equatable {
  const ExploreNotificationsState({
    this.status = NotificationsStatus.loading,
    this.notifications = const [],
    this.failure,
  });

  final NotificationsStatus status;
  final List<AppNotification> notifications;
  final Failure? failure;

  ExploreNotificationsState copyWith({
    NotificationsStatus? status,
    List<AppNotification>? notifications,
    Failure? failure,
  }) {
    return ExploreNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, notifications, failure];
}
