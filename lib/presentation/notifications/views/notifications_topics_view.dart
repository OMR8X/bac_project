import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/core/widgets/ui/states/empty_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';
import 'package:bac_project/presentation/notifications/state/topics_management/notifications_topics_bloc.dart';
import 'package:bac_project/presentation/notifications/widgets/notification_topic_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spacing_resources.dart';
import '../../../core/widgets/animations/skeletonizer_effect_list_wraper.dart';

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
              NotificationsTopicsStatus.loading => const _LoadingView(),
              NotificationsTopicsStatus.failure => ErrorStateBodyWidget(
                title: "حدث خطأ في تحميل مواضيع الإشعارات",
                failure: state.failure,
                onRetry: () => sl<NotificationsTopicsBloc>().add(const LoadTopicsEvent()),
              ),
              NotificationsTopicsStatus.loaded =>
                state.topics.isEmpty ? const EmptyStateBodyWidget() : _LoadedView(state: state),
            },
          );
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({
    super.key,
    required this.state,
  });

  final NotificationsTopicsState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.screenSidesPadding,
      child: AnimationLimiter(
        child: ListView.builder(
          padding: Paddings.listViewPadding,
          key: const ValueKey("notifications_topics_list_builder_widget"),
          itemCount: state.topics.length,
          itemBuilder: (context, index) {
            final topic = state.topics[index];
            final isSubscribed = state.subscribedTopicIds.contains(topic.id);
            return StaggeredItemWrapperWidget(
              position: index,
              child: NotificationTopicCardWidget(
                topic: topic,
                isSubscribed: isSubscribed,
                onToggleSubscription: (value) {
                  if (value) {
                    context.read<NotificationsTopicsBloc>().add(
                      SubscribeToTopicEvent(topic: topic),
                    );
                  } else {
                    context.read<NotificationsTopicsBloc>().add(
                      UnsubscribeFromTopicEvent(topic: topic),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: _LoadedView(
        state: NotificationsTopicsState(
          status: NotificationsTopicsStatus.loaded,
          topics: List.generate(5, (index) => NotificationsTopic.mock()),
          subscribedTopicIds: [],
          failure: null,
        ),
      ),
    );
  }
}
