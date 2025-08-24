import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'result_card_widget.dart';

class ResultListBuilderWidget extends StatelessWidget {
  final List<ResultModel> results;

  const ResultListBuilderWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text('لا توجد نتائج'));
    }

    return Padding(
      padding: PaddingResources.screenSidesPadding,
      child: AnimationLimiter(
        child: ListView.builder(
          padding: PaddingResources.listViewPadding,
          itemCount: results.length,

          itemBuilder: (context, index) {
            final result = results[index];
            return StaggeredItemWrapperWidget(
              position: index,
              child: ResultCardWidget(result: result),
            );
          },
        ),
      ),
    );
  }
}
