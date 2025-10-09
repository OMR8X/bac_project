import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/routes.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PreviousResultCardWidget extends StatelessWidget {
  const PreviousResultCardWidget({super.key, required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: Paddings.zero,
      onTap: () {
        context.pushReplacement(
          Routes.exploreResult.path,
          extra: ExploreResultViewArguments(resultId: result.id),
        );
      },
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${(result.score).toStringAsFixed(0)}%",
              style: TextStylesResources.cardMediumTitle.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Image.asset(
            UIImagesResources.calendarBlankUIIcon,
            height: FontSizeResources.s10,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(width: SpacesResources.s2),
          Text(
            DateFormat('yyyy-MM-dd').format(result.createdAt),
            style: TextStylesResources.cardSmallSubtitle.copyWith(
              fontSize: FontSizeResources.s10,
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: SpacesResources.s4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                durationToText(Duration(seconds: result.durationSeconds)),
                style: TextStylesResources.cardSmallTitle.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeightResources.regular,
                ),
              ),
            ),
            const SizedBox(width: SpacesResources.s2),
            Image.asset(
              UIImagesResources.timerUIIcon,
              height: FontSizeResources.s14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String durationToText(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
