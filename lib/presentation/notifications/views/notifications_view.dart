import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/widgets/animations/skeletonizer_effect_list_wraper.dart';
import 'package:bac_project/core/widgets/ui/icons/arrow_back_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/states/empty_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/features/notifications/data/settings/app_local_notifications_settings.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:bac_project/presentation/notifications/widgets/notification_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final ScrollController _scrollController = ScrollController();
  static const double _scrollThreshold = 200.0; // Load more when 200 pixels from bottom

  @override
  void initState() {
    super.initState();
    sl<NotificationsBloc>().add(const LoadNotificationsEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      sl<NotificationsBloc>().add(const LoadMoreNotificationsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return maxScroll - currentScroll <= _scrollThreshold;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NotificationsBloc>(),
      child: BlocConsumer<NotificationsBloc, ExploreNotificationsState>(
        listener: (context, state) {
          if (state.status == NotificationsStatus.success) {
            final unreadNotifications =
                state.notifications.where((e) {
                  return e.readedAt == null;
                }).toList();
            sl<NotificationsBloc>().add(
              MarkNotificationsAsReadEvent(
                notificationIds: unreadNotifications.map((e) => e.id.toString()).toList(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.navigationNotifications),
              leading: CloseIconWidget(),
              actions: [
                if (kDebugMode) SwitchThemeIconWidget(),
              ],
            ),
            body: switch (state.status) {
              NotificationsStatus.loading => _LoadingView(),
              NotificationsStatus.failure => ErrorStateBodyWidget(
                title: "حدث خطأ في تحميل الإشعارات",
                failure: state.failure,
                onRetry: () => sl<NotificationsBloc>().add(const LoadNotificationsEvent()),
              ),
              NotificationsStatus.success =>
                state.notifications.isEmpty
                    ? const EmptyStateBodyWidget()
                    : _LoadedView(scrollController: _scrollController, state: state),
            },
          );
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Theme.of(context).colorScheme.surface,
      child: _LoadedView(
        scrollController: ScrollController(),
        state: ExploreNotificationsState(
          notifications: List.generate(5, (index) => AppNotification.mock()),
          isLoadingMore: false,
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({
    super.key,
    required this.scrollController,
    required this.state,
  });
  final ScrollController scrollController;
  final ExploreNotificationsState state;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: scrollController,
        padding: Paddings.zero,
        key: const ValueKey("notifications_list_builder_widget"),
        itemCount: state.notifications.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.notifications.length) {
            return SkeletonizerEffectListWrapper.pagination(
              child: NotificationCardWidget(
                notification: AppNotification.mock(),
                position: 0,
              ),
            );
          }
          final notification = state.notifications[index];
          return NotificationCardWidget(
            notification: notification,
            position: index,
          );
        },
      ),
    );
  }
}
