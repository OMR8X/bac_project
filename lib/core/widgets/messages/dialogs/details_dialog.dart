import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

showDetailsDialog({required BuildContext context, required Widget content, required String title}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: Paddings.dialog,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              Text(title, style: TextStylesResources.dialogTitle, textAlign: TextAlign.center),

              ///
              Padding(padding: Paddings.dialogBody, child: content),

              Divider(),

              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(context.l10n.buttonsConfirm),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
