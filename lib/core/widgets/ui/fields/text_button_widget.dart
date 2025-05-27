import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../resources/styles/sizes_resources.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({super.key, this.textColor, this.borderColor, this.onPressed, this.loading = false, this.miniButton = false, this.centerText = true, required this.title, this.width, this.height, this.icon});
  final bool loading, miniButton, centerText;
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? width, height;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SizedBox(
            width: width ?? SizesResources.mainWidth(context),
            height: height ?? 50,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10),
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(side: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.outline), borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: loading ? null : onPressed,
              child:
                  loading
                      ? const CupertinoActivityIndicator()
                      : Row(
                        children: [
                          Expanded(child: Text(title, textAlign: centerText ? TextAlign.center : TextAlign.start, style: TextStyle(fontSize: miniButton ? 10 : 12, fontWeight: miniButton ? FontWeight.w600 : FontWeight.w600, color: textColor))),
                          if (icon != null) icon!,
                        ],
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
