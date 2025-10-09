part of 'notifications_bloc.dart';

enum NotificationsStatus { loading, success, failure }

final class ExploreNotificationsState extends Equatable {
  const ExploreNotificationsState({
    this.status = NotificationsStatus.loading,
    this.notifications = const [],
    this.failure,
    this.readNotificationIds = const {},
    this.isLoadingMore = false,
    this.hasMoreData = true,
    this.currentOffset = 0,
    this.pageSize = 20,
  });

  final NotificationsStatus status;
  final List<AppNotification> notifications;
  final Failure? failure;
  final Set<String> readNotificationIds;
  final bool isLoadingMore;
  final bool hasMoreData;
  final int currentOffset;
  final int pageSize;

  ExploreNotificationsState copyWith({
    NotificationsStatus? status,
    List<AppNotification>? notifications,
    Failure? failure,
    Set<String>? readNotificationIds,
    bool? isLoadingMore,
    bool? hasMoreData,
    int? currentOffset,
    int? pageSize,
  }) {
    return ExploreNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      failure: failure ?? this.failure,
      readNotificationIds: readNotificationIds ?? this.readNotificationIds,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentOffset: currentOffset ?? this.currentOffset,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
    status,
    notifications,
    failure,
    readNotificationIds,
    isLoadingMore,
    hasMoreData,
    currentOffset,
    pageSize,
  ];
}
