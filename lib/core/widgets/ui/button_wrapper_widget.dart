import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/border_radius_resources.dart';
import '../../resources/styles/spacing_resources.dart';

class ButtonWrapperWidget extends StatelessWidget {
  const ButtonWrapperWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (backgroundColor(context) ?? Colors.transparent).darker(0.5),
        borderRadius: BorderRadiusResource.bordersRadiusMedium,
      ),
      child: Padding(
        padding: Paddings.customButtonPadding,
        child: child,
      ),
    );
  }

  Color? backgroundColor(BuildContext context) {
    return buttonStyle(context)?.backgroundColor?.resolve(Set.from([WidgetState.values]));
  }

  ButtonStyle? buttonStyle(BuildContext context) {
    switch (child.runtimeType) {
      case ElevatedButton:
        return Theme.of(context).elevatedButtonTheme.style;
      case TextButton:
        return Theme.of(context).textButtonTheme.style;
      case OutlinedButton:
        return Theme.of(context).outlinedButtonTheme.style;
      default:
        return null;
    }
  }
}
