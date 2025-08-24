import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:bac_project/presentation/home/widgets/lessons_navigation_card_bilder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc/search_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.arguments});
  final SearchViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.searchTitle),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: PaddingResources.screenSidesPadding,
            child: CustomScrollView(
              slivers: [
                SliverFloatingHeader(
                  snapMode: FloatingHeaderSnapMode.overlay,
                  child: SearchBarWidget(
                    heroTag: arguments.heroTag,
                    onChanged: (searchText) {
                      context.read<SearchBloc>().add(
                        SearchLessons(unitId: arguments.unitId, searchText: searchText),
                      );
                    },
                    onFieldSubmitted: (searchText) {
                      context.read<SearchBloc>().add(
                        SearchLessons(unitId: arguments.unitId, searchText: searchText),
                      );
                    },
                  ),
                ),
                if (state.status == SearchStatus.initial)
                  LessonsCardsBuilderWidget(lessons: state.lessons),

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
