import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:flutter/material.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsContactUs),
      ),
      body: const SizedBox(),
    );
  }
}

