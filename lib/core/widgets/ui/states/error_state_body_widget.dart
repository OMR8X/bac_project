import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class ErrorStateBodyWidget extends StatelessWidget {
  const ErrorStateBodyWidget({
    super.key,
    required this.title,
    required this.failure,
    required this.onRetry,
    required this.onCancel,
  });
  final String title;
  final Failure failure;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: PaddingResources.screenBodyPadding,
        child: Column(
          children: [
            Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error,
                color: Colors.red,
                size: 80,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              failure.message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  context.l10n.buttonsRetry,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            const SizedBox(height: SpacesResources.s4),
            if (onCancel != null)
              ElevatedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  context.l10n.buttonsClose,
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
