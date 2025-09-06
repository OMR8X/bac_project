import 'package:bac_project/core/widgets/ui/icons/notifications_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/switch_theme_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/build_context_l10n.dart';
import '../../../core/injector/app_injection.dart';
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
      appBar: AppBar(title: Text(context.l10n.resultsTitle), leading: NotificationsIconWidget(), actions: [SwitchThemeWidget()]),
      body: BlocConsumer<ExploreResultsBloc, ExploreResultsState>(
        bloc: sl<ExploreResultsBloc>(),
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
            return ResultListBuilderWidget(results: state.results);
          }

          return const Center();
        },
      ),
    );
  }
}
