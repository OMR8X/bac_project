import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/core/injector/app_injection.dart';

import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';

class QuizzingAnswerNavigation extends StatelessWidget {
  const QuizzingAnswerNavigation({
    super.key,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onNextOrSubmit,
  });

  final bool canGoPrevious;
  final bool canGoNext;
  final VoidCallback onPrevious;
  final VoidCallback onNextOrSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
              ),
              onPressed: canGoPrevious ? onPrevious : null,
              child: Text(
                context.l10n.buttonsPrevious,
                style: TextStyle(
                  color:
                      canGoPrevious
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: SpacesResources.s3),
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
              ),
              onPressed: onNextOrSubmit,
              child: Text(context.l10n.buttonsNext),
            ),
          ),
        ],
      ),
    );
  }
}
