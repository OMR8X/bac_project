import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:flutter/material.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsUpdateMyPassword),
        leading: const CloseIconWidget(),
      ),
      body: const SizedBox(),
    );
  }
}

