// Start of Selection
import 'package:neuro_app/core/widgets/messages/snackbars/snackbar_widget.dart';
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
      icon: Icons.do_not_disturb_alt_outlined,
    ).call(),
  );
}
