import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/remote_notification.dart';
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
        child: Container(
          margin: Margins.cardMargin,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleNotificationTap(context),
              child: Padding(
                padding: Paddings.cardMediumPadding.copyWith(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: SpacesResources.s3),
                    _buildContent(context),
                    const SizedBox(height: SpacesResources.s4),
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      notification.title,
      style: TextStylesResources.cardMediumTitle.copyWith(
        color: _getTitleColor(context),
        fontSize: FontSizeResources.s14,
        fontWeight: _getTitleWeight(),
        height: 1.2,
        letterSpacing: 0.5,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildContent(BuildContext context) {
    if (notification.body.isEmpty) return const SizedBox.shrink();

    return Text(
      notification.body,
      style: TextStylesResources.caption.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: FontSizeResources.s11,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        // if (notification.topicTitle != null && notification.topicTitle!.isNotEmpty) ...[
        //   Container(
        //     padding: Paddings.customPadding(3, 1),
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.onSurface,
        //       borderRadius: BorderRadiusResource.bordersRadiusTiny,
        //     ),
        //     child: Text(
        //       notification.topicTitle!,
        //       style: TextStylesResources.caption.copyWith(
        //         color: Theme.of(context).colorScheme.primaryContainer,
        //         fontSize: FontSizeResources.s9,
        //         fontWeight: FontWeightResources.medium,
        //       ),
        //     ),
        //   ),
        //   const SizedBox(width: SpacesResources.s2),
        // ],
        Container(
          padding: Paddings.customPadding(3, 1),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadiusResource.bordersRadiusTiny,
          ),
          child: Text(
            timeAgo(notification.createdAt),
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

  FontWeight _getTitleWeight() {
    if (!notification.seen) return FontWeightResources.bold;
    return FontWeightResources.medium;
  }

  void _handleNotificationTap(BuildContext context) {
    // Mark as read and handle navigation
    // This would typically trigger a bloc event
    print('Notification tapped: ${notification.id}');
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
