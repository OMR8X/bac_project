import 'package:flutter/material.dart';

class ShadowsResources {
  static List<BoxShadow> cardShadows(BuildContext context) => [
    BoxShadow(
      color: Theme.of(context).colorScheme.outline,
      blurRadius: 0,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
    BoxShadow(
      color: Theme.of(context).colorScheme.shadow.withAlpha(12),
      spreadRadius: 2,
      blurRadius: 3,
      offset: Offset(0, 3),
    ),
  ];
}
