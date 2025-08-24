import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/decoration_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/dialogs/conform_dialog.dart';
import 'package:bac_project/presentation/notifications/state/explore_notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/font_styles_manager.dart';
import '../../../core/resources/styles/padding_resources.dart';
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
        sl<ExploreNotificationsBloc>().add(LoadExploreNotificationsEvent());
      },
      child: BlocProvider.value(
        value: sl<ExploreNotificationsBloc>(),
        child: BlocBuilder<ExploreNotificationsBloc, ExploreNotificationsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("الاشعارات"),
                actions: [
                  if (state.notifications.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        showConformDialog(
                          context: context,
                          title: "حذف سجل الاشعارات",
                          body: "هل ترغب في حذف سجل الاشعارات؟",
                          action: "حذف",
                          onConform: () {
                            sl<ExploreNotificationsBloc>().add(
                              const ClearExploreNotificationsEvent(),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.cleaning_services,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                ],
              ),
              body: ListView.builder(
                key: const ValueKey("reports_list_builder_widget"),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return NotificationTileWidget(notification: notification, position: index);
                },
              ),
            );
          },
        ),
      ),
    );
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
            margin: PaddingResources.cardOuterPadding,
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
                  padding: PaddingResources.customPadding(5, 5),
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
                                UIImagesResources.notificationsIcon,
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
                                Flexible(
                                  child: Text(notification.title, textAlign: TextAlign.start),
                                ),
                                Text("  ${timeAgo(notification.date)}"),
                              ],
                            ),
                            if (notification.subtitle?.isNotEmpty ?? false) ...[
                              SizedBox(height: SpacesResources.s3),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("${notification.subtitle!} "),
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
      return ' ';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}د';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}س';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}ي';
    } else {
      return intl.DateFormat('yyyy-MM-dd').format(dateTime); // Fallback for older dates
    }
  }
}
