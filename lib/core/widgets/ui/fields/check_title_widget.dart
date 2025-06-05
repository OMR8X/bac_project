import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/styles/sizes_resources.dart';

class CheckTitleWidget extends StatelessWidget {
  const CheckTitleWidget({
    super.key,
    required this.text,
    required this.onChange,
    this.value = false,
  });
  final String text;
  final bool value;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: SizesResources.mainWidth(context),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {
                HapticFeedback.lightImpact();
                onChange(value ?? false);
              },
            ),
            // keep me logged in text arabic
            Text(text, style: AppTextStyles.title),
          ],
        ),
      ),
    );
  }
}
