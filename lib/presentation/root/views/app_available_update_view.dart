import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_project/core/widgets/ui/fields/text_button_widget.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';
import 'package:flutter/material.dart';

class UpdateAvailableView extends StatelessWidget {
  const UpdateAvailableView({
    super.key,
    required this.version,
  });
  final Version version;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Icon(Icons.update, size: SpacesResources.s50),
            SizedBox(height: SpacesResources.s4),
            Text("يتوفر تحديث جديد", style: TextStylesResources.button),
            SizedBox(height: SpacesResources.s4),
            Text("الاصدار الحالي ${version.appVersion}", style: TextStylesResources.largeTitle),
            SizedBox(height: SpacesResources.s2),
            Text("الاصدار الجديد ${version.currentVersion}", style: TextStylesResources.largeTitle),
            Spacer(),
            ElevatedButtonWidget(title: "تحديث", onPressed: () {}),
            if (!version.updateRequired)
              TextButtonWidget(title: "تخطي", onPressed: () {})
            else
              Column(
                children: [
                  SizedBox(height: SpacesResources.s2),
                  Text("التحديث مطلوب", style: TextStylesResources.button),
                ],
              ),
            SizedBox(height: SpacesResources.s10),
          ],
        ),
      ),
    );
  }
}
