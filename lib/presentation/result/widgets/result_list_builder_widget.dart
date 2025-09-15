import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/animations/staggered_item_wrapper_widget.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'result_card_widget.dart';

class ResultListBuilderWidget extends StatelessWidget {
  final List<Result> results;

  const ResultListBuilderWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text('لا توجد نتائج'));
    }

    return Padding(
      padding: Paddings.screenSidesPadding,
      child: AnimationLimiter(
        child: ListView.builder(
          padding: Paddings.listViewPadding,
          itemCount: results.length,

          itemBuilder: (context, index) {
            final result = results[index];
            return StaggeredItemWrapperWidget(
              position: index,
              child: ResultCardWidget(
                result: result,
                onExplore: () {
                  context.push(
                    AppRoutes.exploreResult.path,
                    extra: ExploreResultViewArguments(resultId: result.id),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
