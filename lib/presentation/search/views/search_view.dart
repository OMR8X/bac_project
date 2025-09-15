import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/bloc/search_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.arguments});
  final SearchViewArguments arguments;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    context.read<SearchBloc>().add(SearchLessons(unitId: (widget.arguments.unitId)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.searchTitle), leading: CloseIconWidget()),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.message?.isNotEmpty ?? false) {
            Fluttertoast.showToast(msg: state.message!);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: Paddings.screenSidesPadding,
            child: CustomScrollView(
              slivers: [
                SliverFloatingHeader(
                  snapMode: FloatingHeaderSnapMode.overlay,
                  child: SearchBarWidget(
                    heroTag: widget.arguments.heroTag,
                    onChanged: (searchText) {
                      context.read<SearchBloc>().add(
                        SearchLessons(unitId: widget.arguments.unitId, searchText: searchText),
                      );
                    },
                    onFieldSubmitted: (searchText) {
                      context.read<SearchBloc>().add(
                        SearchLessons(unitId: widget.arguments.unitId, searchText: searchText),
                      );
                    },
                  ),
                ),
                if (state.status == SearchStatus.initial)
                  SliverPadding(
                    padding: Paddings.listViewPadding,
                    sliver: LessonsCardsBuilderWidget(lessons: state.lessons),
                  ),

                if (state.status == SearchStatus.searching) _SearchLoadingView(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchLoadingView extends StatelessWidget {
  const _SearchLoadingView({required this.state});

  final SearchState state;
  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(child: Center(child: LoadingWidget()));
  }
}
