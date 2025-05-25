import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

showConformDialog({required BuildContext context, required VoidCallback onConform, required String title, required String body, required String action}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1)),
        child: SizedBox(
          width: SizesResources.mainHalfWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              const SizedBox(height: SpacesResources.s15),

              ///
              Padding(padding: PaddingResources.padding_1_0, child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),

              ///
              const SizedBox(height: SpacesResources.s4),

              ///
              Padding(padding: PaddingResources.padding_2_0, child: Text(body, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center)),

              ///
              const SizedBox(height: SpacesResources.s15),
              const Divider(height: 1, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("الغاء", style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  const SizedBox(width: 2, height: 30, child: VerticalDivider(width: 1, thickness: 1)),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConform();
                      },
                      child: Text(action, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
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
