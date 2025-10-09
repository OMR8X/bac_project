import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key, required this.notification, required this.position});

  final int position;
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${notification.title}${notification.body.isNotEmpty ? ', ${notification.body}' : ''}',
      explicitChildNodes: true,
      child: StaggeredListWrapperWidget(
        key: ValueKey(notification),
        position: position,
        child: InkWell(
          onTap: () {
            sl<DisplayNotificationUsecase>().call(
              notification: notification,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  notification.readedAt == null
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            padding: Paddings.notificationCardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBoxes.s4v,
                _buildContent(context),
                SizedBoxes.s5v,
                _buildFooter(context),
              ],
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
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: FontSizeResources.s13,
        fontWeight: FontWeightResources.medium,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: Paddings.customPadding(3, 1),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadiusResource.bordersRadiusTiny,
          ),
          child: Text(
            topicTitle(context),
            style: TextStylesResources.caption.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: FontSizeResources.s9,
              fontWeight: FontWeightResources.medium,
            ),
          ),
        ),
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
