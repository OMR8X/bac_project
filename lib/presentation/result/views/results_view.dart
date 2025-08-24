import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
import '../../result/bloc/explore_results_bloc.dart';
import '../widgets/result_list_builder_widget.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  late final ExploreResultsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl<ExploreResultsBloc>();
    bloc.add(const FetchResults());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.resultTitle)),
      body: BlocConsumer<ExploreResultsBloc, ExploreResultsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ExploreResultsLoaded) {
            if (state.message != null && state.message!.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Fluttertoast.showToast(msg: state.message!);
              });
            }
          }
        },
        builder: (context, state) {
          if (state is ExploreResultsLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is ExploreResultsLoaded) {
            final results = state.results.cast<dynamic>();
            return ResultListBuilderWidget(results: results.cast());
          }

          return const Center();
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
