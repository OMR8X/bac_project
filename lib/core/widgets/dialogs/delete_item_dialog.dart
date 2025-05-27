import 'dart:math';

import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/styles/sizes_resources.dart';

showDeleteItemDialog({required BuildContext context, required VoidCallback onConform, required String item}) {
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
              Text("حذف ملف", style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),

              ///
              const SizedBox(height: SpacesResources.s8),

              ///
              Padding(padding: PaddingResources.padding_5_0, child: Text('هل انت متاكد من انك تريد حذف "$item" ؟', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center)),

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
                      child: Text("تراجع", style: Theme.of(context).textTheme.labelMedium),
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
                      child: Text("حذف", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.error)),
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
