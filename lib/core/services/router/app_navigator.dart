import 'package:flutter/material.dart';

extension NavigationHelpersExt on BuildContext {
  AppNavigator get navigator => AppNavigator(this);
}

class AppNavigator {
  AppNavigator(this.context);

  final BuildContext context;
}
