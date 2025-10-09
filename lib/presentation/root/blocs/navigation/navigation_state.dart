part of 'navigation_cubit.dart';

enum NavigationStatus {
  initializing,
  unauthorized,
  authenticating,
  updateAvailable,
  ready,
}

final class NavigationState extends Equatable {
  const NavigationState({this.pendingRoute, this.status = NavigationStatus.initializing});
  final NavigationStatus status;
  final String? pendingRoute;
  @override
  List<Object?> get props => [pendingRoute, status];

  factory NavigationState.initializing() {
    return NavigationState(pendingRoute: null, status: NavigationStatus.initializing);
  }

  NavigationState copyWith({
    NavigationStatus? status,
    bool setPendingToNull = false,
    String? pendingRoute,
  }) {
    return NavigationState(
      status: status ?? this.status,
      pendingRoute: (setPendingToNull == true) ? null : pendingRoute ?? this.pendingRoute,
    );
  }
}
