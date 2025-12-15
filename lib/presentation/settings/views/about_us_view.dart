import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/ui/icons/arrow_back_icon_widget.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackIconWidget(),
        title: Text(context.l10n.settingsAboutUs),
      ),
      body: const SizedBox(),
    );
  }
}
