import 'package:bac_project/core/widgets/messages/snackbars/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertSnackbar({
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
      backgroundColor: Color(0xFFA5A1B0),
      icon: Icons.info_outline,
    ).call(),
  );
}
