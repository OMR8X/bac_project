import 'package:neuro_app/core/injector/app_injection.dart';
import 'package:neuro_app/core/resources/styles/border_radius_resources.dart';
import 'package:neuro_app/core/resources/styles/font_styles_manager.dart';
import 'package:neuro_app/core/resources/styles/spaces_resources.dart';
import 'package:neuro_app/core/resources/styles/spacing_resources.dart';
import 'package:neuro_app/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:neuro_app/features/notifications/domain/entities/app_notification.dart';
import 'package:neuro_app/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key, required this.notification, required this.position});

  final int position;
  final AppNotification notification;

  bool get isUnread => notification.readAt == null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${notification.title}${notification.body.isNotEmpty ? ', ${notification.body}' : ''}',
      explicitChildNodes: true,
      child: StaggeredListWrapperWidget(
        key: ValueKey(notification),
        position: position,
        child: Card(
          margin: Margins.cardMargin,
          child: InkWell(
            borderRadius: BorderRadiusResource.cardBorderRadius,
            onTap: () {
              sl<DisplayNotificationUsecase>().call(
                notification: notification,
              );
            },
            child: Padding(
              padding: Paddings.cardMediumPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // // Unread indicator
                  // if (isUnread)
                  //   Padding(
                  //     padding: EdgeInsets.only(top: SpacesResources.s2, left: SpacesResources.s2),
                  //     child: Container(
                  //       width: SpacesResources.s4,
                  //       height: SpacesResources.s4,
                  //       decoration: BoxDecoration(
                  //         color: Theme.of(context).colorScheme.primary,
                  //         shape: BoxShape.circle,
                  //       ),
                  //     ),
                  //   )
                  // else
                  //   SizedBox(width: SpacesResources.s2),
                  // SizedBoxes.s4h,
                  // Main content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBoxes.s2v,
                        _buildHeader(context),
                        SizedBoxes.s4v,
                        _buildContent(context),
                        SizedBoxes.s4v,
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            notification.title,
            style: TextStylesResources.cardMediumTitle.copyWith(
              color: _getTitleColor(context),
              fontSize: FontSizeResources.s14,
              fontWeight: FontWeightResources.bold,
              height: 1.2,
              letterSpacing: 0.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          timeAgo(notification.createdAt),
          style: TextStylesResources.caption.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: FontSizeResources.s9,
            fontWeight: FontWeightResources.medium,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (notification.body.isEmpty) return const SizedBox.shrink();

    return Text(
      notification.body,
      style: TextStylesResources.caption.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: FontSizeResources.s13,
        fontWeight: FontWeightResources.regular,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    final topic = topicTitle(context);
    if (topic.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SpacesResources.s4,
            vertical: SpacesResources.s2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadiusResource.bordersRadiusXTiny,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                topic,
                style: TextStylesResources.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: FontSizeResources.s9,
                  fontWeight: FontWeightResources.medium,
                ),
              ),
            ],
          ),
        ),
        // Chip(
        //   label: Text(
        //     topic,
        //     style: TextStylesResources.caption.copyWith(
        //       color: Theme.of(context).colorScheme.primary,
        //       fontSize: FontSizeResources.s9,
        //       fontWeight: FontWeightResources.medium,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Helper methods for styling

  Color _getTitleColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
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

  String topicTitle(BuildContext context) {
    return notification.topicTitle ?? '';
  }
}
