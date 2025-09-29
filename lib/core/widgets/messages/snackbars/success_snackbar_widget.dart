import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:bac_project/core/widgets/messages/snackbars/snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../resources/themes/extensions/success_colors.dart';

showSuccessSnackbar({
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
      backgroundColor: Theme.of(context).extension<SuccessColors>()!.success,
      titleColor: Theme.of(context).extension<SuccessColors>()!.onSuccess,
      subtitleColor: Theme.of(context).extension<SuccessColors>()!.onSuccess,
      iconContainerColor: Theme.of(context).extension<SuccessColors>()!.onSuccess,
      iconColor: Theme.of(context).extension<SuccessColors>()!.success,
      icon: Icons.notifications_outlined,
    ).call(),
  );
}
