import 'dart:math';

import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/styles/sizes_resources.dart';

showCancelItemDialog({
  required BuildContext context,
  required VoidCallback onConform,
  required String item,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
        ),
        child: SizedBox(
          width: SizesResources.mainHalfWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              const SizedBox(height: SpacesResources.s15),

              ///
              Text(
                "ازالة العنصر",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeightResources.extraBold),
                textAlign: TextAlign.center,
              ),

              ///
              const SizedBox(height: SpacesResources.s4),

              ///
              Padding(
                // TODO: add padding
                padding: EdgeInsets.zero,
                // padding: PaddingResources.padding_5_0,
                child: Text(
                  'هل انت متاكد من انك تريد ازالة "$item" ؟',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(height: 2),
                  textAlign: TextAlign.center,
                ),
              ),

              ///
              const SizedBox(height: SpacesResources.s15),
              const Divider(height: 1, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("تراجع", style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                    height: 30,
                    child: VerticalDivider(width: 1, thickness: 1),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConform();
                      },
                      child: Text(
                        "حذف",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
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
