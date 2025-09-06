part of 'notifications_bloc.dart';

enum NotificationsStatus { initial, loading, success, failure }

final class ExploreNotificationsState extends Equatable {
  const ExploreNotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  final NotificationsStatus status;
  final List<AppNotification> notifications;
  final String? errorMessage;

  ExploreNotificationsState copyWith({
    NotificationsStatus? status,
    List<AppNotification>? notifications,
    String? errorMessage,
  }) {
    return ExploreNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notifications, errorMessage];
}
