import 'package:bac_project/core/services/router/app_router.dart';
import 'package:bac_project/core/widgets/ui/states/empty_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/loading_state_body_widget.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:bac_project/presentation/notifications/widgets/notification_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spacing_resources.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    sl<NotificationsBloc>().add(const LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
     
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Durations.medium4);
        sl<NotificationsBloc>().add(LoadNotificationsEvent());
      },
      child: BlocProvider.value(
        value: sl<NotificationsBloc>(),
        child: BlocBuilder<NotificationsBloc, ExploreNotificationsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.navigationNotifications),
                actions: [],
              ),
              body: switch (state.status) {
                NotificationsStatus.loading => const LoadingStateBodyWidget(),
                NotificationsStatus.failure => ErrorStateBodyWidget(
                  title: "حدث خطأ في تحميل الإشعارات",
                  failure: state.failure,
                  onRetry: () => sl<NotificationsBloc>().add(const LoadNotificationsEvent()),
                ),
                NotificationsStatus.success =>
                  state.notifications.isEmpty
                      ? const EmptyStateBodyWidget()
                      : Padding(
                        padding: Paddings.screenSidesPadding,
                        child: ListView.builder(
                          padding: Paddings.listViewPadding,
                          key: const ValueKey("notifications_list_builder_widget"),
                          itemCount: state.notifications.length,
                          itemBuilder: (context, index) {
                            final notification = state.notifications[index];
                            return NotificationCardWidget(
                              notification: notification,
                              position: index,
                            );
                          },
                        ),
                      ),
              },
            );
          },
        ),
      ),
    );
  }
}
