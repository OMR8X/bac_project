import 'package:bac_project/core/widgets/messages/snackbars/snackbar_widget.dart';
import 'package:flutter/material.dart';

showInformationsSnackbar({
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
      backgroundColor: Color(0xFF4F7BFF),
      icon: Icons.notifications_outlined,
    ).call(),
  );
}
