import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationTopicCardWidget extends StatelessWidget {
  const NotificationTopicCardWidget({
    super.key,
    required this.topic,
    required this.isSubscribed,
    required this.onToggleSubscription,
    required this.position,
  });

  final NotificationsTopic topic;
  final bool isSubscribed;
  final VoidCallback onToggleSubscription;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${topic.title}${topic.description != null ? ', ${topic.description}' : ''}',
      explicitChildNodes: true,
      child: Card(
        margin: Margins.cardMargin,
        child: ListTile(
          contentPadding: Paddings.cardSmallPadding,
          title: Text(
            topic.title,
            style: TextStylesResources.cardMediumTitle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: FontSizeResources.s14,
              fontWeight: FontWeightResources.medium,
              height: 1.2,
              letterSpacing: 0.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle:
              topic.description != null && topic.description!.isNotEmpty
                  ? Text(
                    topic.description!,
                    style: TextStylesResources.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: FontSizeResources.s11,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                  : null,
          trailing: Switch(
            value: isSubscribed,
            onChanged: (value) {
              HapticFeedback.lightImpact();
              onToggleSubscription();
            },
          ),
        ),
      ),
    );
  }
}
