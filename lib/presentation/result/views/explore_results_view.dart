import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/core/widgets/animations/skeletonizer_effect_list_wraper.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';
import 'package:bac_project/presentation/result/widgets/result_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spacing_resources.dart';
import '../bloc/explore_results/explore_results_bloc.dart';
import '../widgets/result_list_builder_widget.dart';

class ExploreResultsView extends StatefulWidget {
  const ExploreResultsView({super.key});

  @override
  State<ExploreResultsView> createState() => _ExploreResultsViewState();
}

class _ExploreResultsViewState extends State<ExploreResultsView> {
  @override
  void initState() {
    super.initState();
    sl<ExploreResultsBloc>().add(const FetchResults());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.resultsTitle)),
      body: BlocBuilder<ExploreResultsBloc, ExploreResultsState>(
        bloc: sl<ExploreResultsBloc>(),
        builder: (context, state) {
          if (state.isLoading) {
            return const _ExploreResultsLoadingWidget();
          }

          if (state.isFailure) {
            return ErrorStateBodyWidget(
              title: context.l10n.errorLoadingResults,
              failure: state.failure,
              onRetry: () => sl<ExploreResultsBloc>().add(const FetchResults()),
            );
          }

          if (state.isLoaded) {
            return ResultListBuilderWidget(results: state.results);
          }

          return const _ExploreResultsLoadingWidget();
        },
      ),
    );
  }
}

class _ExploreResultsLoadingWidget extends StatelessWidget {
  const _ExploreResultsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ResultListBuilderWidget(results: List.generate(5, (index) => Result.mock())),
    );
  }
}
