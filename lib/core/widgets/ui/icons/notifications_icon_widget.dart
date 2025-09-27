import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/ui/icons/appbar_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBarIconWidget(
      icon: Image.asset(
        UIImagesResources.bellUIIcon,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () {
        context.pushNamed(AppRoutes.notifications.name);
      },
    );
  }
}
