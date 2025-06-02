import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(sl<LocalizationManager>().get(LocalizationKeys.settings.title))), body: Column(children: []));
  }
}
