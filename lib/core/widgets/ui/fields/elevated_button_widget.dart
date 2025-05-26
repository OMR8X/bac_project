import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../resources/styles/sizes_resources.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({super.key, this.textColor, this.backgroundColor, this.onPressed, this.loading = false, this.miniButton = false, this.centerText = true, required this.title, this.width, this.height, this.icon, this.position = 1});
  final bool loading, miniButton, centerText;
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double? width, height;
  final Widget? icon;
  final int position;

  @override
  Widget build(BuildContext context) {
    return StaggeredItemWrapperWidget(
      position: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: SizedBox(
              width: width ?? SizesResources.mainWidth(context),
              height: height ?? 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: backgroundColor, elevation: 0),
                onPressed:
                    loading
                        ? null
                        : () {
                          HapticFeedback.lightImpact();
                          onPressed?.call();
                        },
                child:
                    loading
                        ? const CupertinoActivityIndicator()
                        : Row(children: [Expanded(child: Text(title, textAlign: centerText ? TextAlign.center : TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeightResources.bold, color: textColor))), if (icon != null) icon!]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
