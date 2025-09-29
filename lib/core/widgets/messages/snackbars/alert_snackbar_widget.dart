import 'package:bac_project/core/widgets/messages/snackbars/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertSnackbar({
  required BuildContext context,
  required String title,
  required String subtitle,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackbarWidget(
      context: context,
      title: title,
      subtitle: subtitle,
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      titleColor: Theme.of(context).colorScheme.surface,
      subtitleColor: Theme.of(context).colorScheme.surface,
      iconContainerColor: Theme.of(context).colorScheme.surfaceContainer,
      iconColor: Theme.of(context).colorScheme.onSurface,
      icon: Icons.notifications_outlined,
    ).call(),
  );
}
