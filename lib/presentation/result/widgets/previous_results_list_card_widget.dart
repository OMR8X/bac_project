import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'previous_result_card_widget.dart';

class PreviousResultsListCardWidget extends StatelessWidget {
  const PreviousResultsListCardWidget({super.key, required this.results});

  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

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
            ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 1, thickness: 1),
              padding: Paddings.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return PreviousResultCardWidget(result: results[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
