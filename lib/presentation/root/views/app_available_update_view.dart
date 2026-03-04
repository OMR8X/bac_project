import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/ui/fields/text_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/injector/tests_feature_inj.dart';
import '../../../core/resources/styles/sizes_resources.dart';
import '../../../core/resources/styles/spacing_resources.dart';
import '../../../features/settings/domain/entities/app_settings.dart';

class UpdateAvailableView extends StatelessWidget {
  const UpdateAvailableView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final version = sl<AppSettings>().version;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Paddings.screenBodyPadding,
          child: Column(
            children: [
              Spacer(),
              SizedBox(height: SpacesResources.s10),
              Icon(
                Icons.update,
                size: SpacesResources.s50,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: SpacesResources.s6),
              Text(
                l10n.updateAvailableTitle,
                style: TextStylesResources.largeTitle.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SpacesResources.s4),
              Text(
                l10n.updateAvailableDescription,
                style: TextStylesResources.button.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SpacesResources.s6),
              Text(
                l10n.updateAvailableCurrentVersion(
                  version.appVersion,
                ),
                style: TextStylesResources.button,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SpacesResources.s3),
              Text(
                l10n.updateAvailableNewVersion(
                  version.currentVersion,
                ),
                style: TextStylesResources.button,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Column(
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                    ),
                    child: Text(l10n.updateAvailablePrimaryButton),
                    onPressed: () {},
                  ),
                  SizedBox(height: SpacesResources.s3),
                  if (!version.updateRequired)
                    TextButtonWidget(
                      title: l10n.updateAvailableSkipButton,
                      onPressed: () {},
                    )
                  else ...[
                    SizedBox(height: SpacesResources.s2),
                    Text(
                      l10n.updateAvailableRequiredMessage,
                      style: TextStylesResources.underButton.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: SpacesResources.s6),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
