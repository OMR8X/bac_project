part of 'notifications_bloc.dart';

final class ExploreNotificationsState extends Equatable {
  const ExploreNotificationsState({
    this.notifications = const [],
  });
  final List<AppNotification> notifications;

  @override
  List<Object?> get props => [notifications];
}
