import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class ErrorStateBodyWidget extends StatelessWidget {
  const ErrorStateBodyWidget({
    super.key,
    required this.title,
    this.failure,
    this.onRetry,
    this.onCancel,
  });
  final String title;
  final Failure? failure;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;
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
                color: Theme.of(context).colorScheme.error.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 80),
            ),
            SizedBoxes.s10v,
            Text(
              title,
              style: TextStylesResources.cardMediumTitle.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxes.s6v,
            Text(
              failure?.message ?? UnknownFailure().message,
              style: TextStylesResources.cardMediumSubtitle.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxes.s10v,
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,

                child: Text(context.l10n.buttonsRetry, style: TextStyle(fontSize: 16)),
              ),
            const SizedBox(height: SpacesResources.s4),
            if (onCancel != null)
              TextButton(
                onPressed: onCancel,
                child: Text(context.l10n.buttonsClose, style: TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}
