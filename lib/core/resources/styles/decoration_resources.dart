import 'package:flutter/material.dart';
import 'border_radius_resources.dart';

class DecorationResources {
  ///
  static BoxDecoration tileDecoration({required ThemeData theme}) {
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadiusResource.tileBorderRadius,
      border: Border(bottom: BorderSide(color: theme.colorScheme.outline, width: 0.5)),
      // boxShadow: [
      //   BoxShadow(
      //     color: theme.colorScheme.shadow,
      //     spreadRadius: 0,
      //     blurRadius: 5.77,
      //     offset: const Offset(2, 2),
      //   ),
      // ],
    );
  }

  ///
  static BoxDecoration tileBoxDecoration({required ThemeData theme}) {
    return BoxDecoration(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadiusResource.tileBoxBorderRadius,
      border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant, width: 0.5)),
      boxShadow: [
        BoxShadow(
          color: theme.colorScheme.shadow,
          spreadRadius: 0,
          blurRadius: 5.77,
          offset: const Offset(2, 2),
        ),
      ],
    );
  }

  static BoxDecoration inputFieldDecoration({required ThemeData theme}) {
    return BoxDecoration(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadiusResource.fieldBorderRadius,
    );
  }

  static BoxDecoration inputDialogDecoration({required ThemeData theme}) {
    return BoxDecoration(
      color: theme.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadiusResource.fieldBorderRadius,
    );
  }
}
