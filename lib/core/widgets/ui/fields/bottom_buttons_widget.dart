import 'dart:ui';

import 'package:bac_project/core/resources/styles/blur_resources.dart';
import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
  });
  final void Function() onPressed;
  final String text;
  final bool isEnabled, isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: PaddingResources.screenSidesPadding,
        child: ClipRRect(
          borderRadius: BorderRadiusResource.buttonBorderRadius,
          child: BackdropFilter(
            filter: BlurResources.buttonBlur(context),
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
              ),
              onPressed: isEnabled ? onPressed : null,
              child: isLoading ? CupertinoActivityIndicator() : Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
