import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

showDeleteItemDialog({
  required BuildContext context,
  required VoidCallback onConform,
  required String item,
}) {
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
              Text(
                "تاكيد عملية الحذف",
                style: TextStylesResources.dialogTitle,
                textAlign: TextAlign.center,
              ),

              ///
              const SizedBox(height: SpacesResources.s8),

              ///
              Text(
                "هل أنت متأكد من حذف $item؟",
                style: TextStylesResources.dialogBody,
                textAlign: TextAlign.center,
              ),

              ///
              const SizedBox(height: SpacesResources.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("الغاء"),
                    ),
                  ),
                  SizedBoxes.s4h,
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConform();
                      },
                      child: Text("حذف"),
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
