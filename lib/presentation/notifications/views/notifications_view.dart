import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/decoration_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spacing_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/animations/staggered_list_wrapper_widget.dart';
import '../../../features/notifications/domain/entities/app_notification.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Durations.medium4);
        sl<ExploreNotificationsBloc>().add(LoadNotificationsEvent());
      },
      child: BlocProvider.value(
        value: sl<ExploreNotificationsBloc>(),
        child: BlocBuilder<ExploreNotificationsBloc, ExploreNotificationsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: const Text("الإشعارات"), actions: [
             
                ],
              ),
              body: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(ExploreNotificationsState state) {
    switch (state.status) {
      case NotificationsStatus.initial:
      case NotificationsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case NotificationsStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                "حدث خطأ في تحميل الإشعارات",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              if (state.errorMessage != null)
                Text(
                  state.errorMessage!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  sl<ExploreNotificationsBloc>().add(const LoadNotificationsEvent());
                },
                child: const Text("إعادة المحاولة"),
              ),
            ],
          ),
        );
      case NotificationsStatus.success:
        if (state.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text("لا توجد إشعارات", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text(
                  "ستظهر الإشعارات هنا عند وصولها",
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          key: const ValueKey("notifications_list_builder_widget"),
          itemCount: state.notifications.length,
          itemBuilder: (context, index) {
            final notification = state.notifications[index];
            return NotificationTileWidget(notification: notification, position: index);
          },
        );
    }
  }
}

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({super.key, required this.notification, required this.position});
  final int position;
  final AppNotification notification;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StaggeredListWrapperWidget(
          key: ValueKey(notification),
          position: position,
          child: Container(
            margin: Margins.cardMargin,
            width: SizesResources.mainWidth(context),
            decoration: DecorationResources.inputDialogDecoration(theme: Theme.of(context)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadiusResource.tileBorderRadius,
              child: InkWell(
                borderRadius: BorderRadiusResource.tileBorderRadius,
                onTap:
                    (notification.html?.isNotEmpty ?? false)
                        ? () {
                          context.push(AppRoutes.notificationDetails.path, extra: notification);
                        }
                        : null,
                child: Padding(
                  padding: Paddings.customPadding(5, 5),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(left: SpacesResources.s5),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
                              borderRadius: BorderRadiusResource.tileBoxBorderRadius,
                            ),
                            child: Center(
                              child: Image.asset(
                                UIImagesResources.bellUIIcon,
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notification.title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  timeAgo(notification.date),
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            if (notification.body?.isNotEmpty ?? false) ...[
                              const SizedBox(height: 4),
                              Text(
                                notification.body!,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (notification.html?.isNotEmpty ?? false)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Icon(Icons.arrow_forward_ios, size: 10),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}د';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}س';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}ي';
    } else {
      return intl.DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }
}
