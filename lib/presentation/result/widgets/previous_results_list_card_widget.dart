import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
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
      child: Padding(
        padding: PaddingResources.cardLargeInnerPadding,
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
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 2, thickness: 1),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${(results[index].score).toStringAsFixed(0)}%",
                          style: AppTextStyles.cardMediumTitle.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        // WidgetSpan(child: SizedBox(width: SpacesResources.s2)),
                        // TextSpan(
                        //   text: "النتيجة",
                        //   style: AppTextStyles.statLabelStyle.copyWith(
                        //     color: Theme.of(context).colorScheme.onSurfaceVariant,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: FontSizeResources.s10,
                        color: theme.colorScheme.onSurface.withAlpha(100),
                      ),
                      const SizedBox(width: SpacesResources.s2),
                      Text(
                        DateFormat('yyyy-MM-dd').format(results[index].createdAt),
                        style: AppTextStyles.cardSmallSubtitle.copyWith(
                          fontSize: FontSizeResources.s10,
                        ),
                      ),
                      // const SizedBox(width: SpacesResources.s4),
                      // Icon(
                      //   Icons.timer_outlined,
                      //   size: FontSizeResources.s10,
                      //   color: theme.colorScheme.onSurface.withAlpha(100),
                      // ),
                      // const SizedBox(width: SpacesResources.s2),
                      // Text(
                      //   DateFormat('kk:mm').format(results[index].createdAt),
                      //   style: AppTextStyles.cardSmallSubtitle.copyWith(
                      //     fontSize: FontSizeResources.s9,
                      //   ),
                      // ),
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
                            style: AppTextStyles.cardSmallTitle.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeightResources.regular,
                            ),
                          ),
                        ),
                        const SizedBox(width: SpacesResources.s4),
                        Icon(
                          Icons.timer_outlined,
                          size: FontSizeResources.s20,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
