// Start of Selection
import 'package:bac_project/core/widgets/messages/snackbars/snackbar_widget.dart';
import 'package:flutter/material.dart';

showErrorSnackbar({
  required BuildContext context,
  required String title,
  String? subtitle,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackbarWidget(
      context: context,
      title: title,
      subtitle: subtitle,
      backgroundColor: Theme.of(context).colorScheme.error,
      titleColor: Theme.of(context).colorScheme.surface,
      subtitleColor: Theme.of(context).colorScheme.surface,
      iconContainerColor: Theme.of(context).colorScheme.errorContainer,
      iconColor: Theme.of(context).colorScheme.error,
      icon: Icons.error_outline,
    ).call(),
  );
}
  