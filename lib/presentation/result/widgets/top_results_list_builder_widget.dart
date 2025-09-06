import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TopResultsListBuilderWidget extends StatelessWidget {
  const TopResultsListBuilderWidget({super.key, required this.results});
  final List<Result> results;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingResources.cardTopResultsPadding,
        child: AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return _TopResultCardWidget(result: result);
            },
          ),
        ),
      ),
    );
  }
}

class _TopResultCardWidget extends StatelessWidget {
  const _TopResultCardWidget({super.key, required this.result});
  final Result result;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          Supabase.instance.client.auth.currentUser?.id == result.userId
              ? Theme.of(context).colorScheme.surfaceContainerHigh
              : null,
      title: Text(result.lessonTitle ?? ''),
      subtitle: Text(result.score.toString()),
      leading: Text(result.resultOrder.toString()),
    );
  }
}
