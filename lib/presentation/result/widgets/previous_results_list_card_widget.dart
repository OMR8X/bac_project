import 'package:bac_project/core/resources/styles/assets_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';

class PreviousResultsListCardWidget extends StatelessWidget {
  const PreviousResultsListCardWidget({super.key, required this.results});

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Card(
      margin: Margins.cardMargin,
      child: Padding(
        padding: Paddings.cardLargePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "النتائج السابقة",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: FontSizeResources.s12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: SpacesResources.s2),
            AnimationLimiter(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 1, thickness: 1),
                padding: Paddings.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return StaggeredListWrapperWidget(
                    position: index,
                    child: ListTile(
                      contentPadding: Paddings.zero,
                      onTap: () {
                        context.pushReplacement(
                          AppRoutes.exploreResult.path,
                          extra: ExploreResultViewArguments(resultId: results[index].id),
                        );
                      },
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${(results[index].score).toStringAsFixed(0)}%",
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
                            DateFormat('yyyy-MM-dd').format(results[index].createdAt),
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
                                durationToText(Duration(seconds: results[index].durationSeconds)),
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
                    ),
                  );
                },
              ),
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
