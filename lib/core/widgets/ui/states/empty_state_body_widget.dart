import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/material.dart';

class EmptyStateBodyWidget extends StatelessWidget {
  const EmptyStateBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Paddings.screenBodyPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inbox_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 64,
              ),
            ),
            SizedBoxes.s10v,
            Text(
              context.l10n.emptyStateTitle,
              style: TextStylesResources.cardMediumTitle.copyWith(
                color: Theme.of(context).colorScheme.primary, 
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxes.s6v,
            Text(
              context.l10n.emptyStateSubtitle,
              style: TextStylesResources.cardMediumSubtitle.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
