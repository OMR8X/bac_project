import 'package:bac_project/core/widgets/ui/states/empty_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/loading_state_body_widget.dart';
import 'package:bac_project/presentation/notifications/state/topics_management/notifications_topics_bloc.dart';
import 'package:bac_project/presentation/notifications/widgets/notification_topic_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spacing_resources.dart';

class NotificationsTopicsView extends StatefulWidget {
  const NotificationsTopicsView({super.key});

  @override
  State<NotificationsTopicsView> createState() => _NotificationsTopicsViewState();
}

class _NotificationsTopicsViewState extends State<NotificationsTopicsView> {
  @override
  void initState() {
    super.initState();
    sl<NotificationsTopicsBloc>().add(const LoadTopicsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NotificationsTopicsBloc>(),
      child: BlocBuilder<NotificationsTopicsBloc, NotificationsTopicsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.notificationTopicsTitle),
              actions: [],
            ),
            body: switch (state.status) {
              NotificationsTopicsStatus.loading => const LoadingStateBodyWidget(),
              NotificationsTopicsStatus.failure => ErrorStateBodyWidget(
                title: "حدث خطأ في تحميل مواضيع الإشعارات",
                failure: state.failure,
                onRetry: () => sl<NotificationsTopicsBloc>().add(const LoadTopicsEvent()),
              ),
              NotificationsTopicsStatus.loaded =>
                state.topics.isEmpty
                    ? const EmptyStateBodyWidget()
                    : Padding(
                      padding: Paddings.screenSidesPadding,
                      child: ListView.builder(
                        padding: Paddings.listViewPadding,
                        key: const ValueKey("notifications_topics_list_builder_widget"),
                        itemCount: state.topics.length,
                        itemBuilder: (context, index) {
                          final topic = state.topics[index];
                          final isSubscribed = state.subscribedTopicIds.contains(topic.id);
                          return NotificationTopicCardWidget(
                            topic: topic,
                            isSubscribed: isSubscribed,
                            onToggleSubscription: () {
                              if (isSubscribed) {
                                context.read<NotificationsTopicsBloc>().add(
                                  UnsubscribeFromTopicEvent(topic: topic),
                                );
                              } else {
                                context.read<NotificationsTopicsBloc>().add(
                                  SubscribeToTopicEvent(topic: topic),
                                );
                              }
                            },
                            position: index,
                          );
                        },
                      ),
                    ),
            },
          );
        },
      ),
    );
  }
}
