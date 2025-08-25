import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/motivational_quote_card_widget.dart';
import 'package:bac_project/presentation/settings/widgets/switch_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/services/router/app_routes.dart';
import '../../../core/widgets/ui/loading_widget.dart';
import '../../../core/widgets/ui/search_bar_widget.dart';
import '../blocs/home_bloc.dart';
import '../widgets/home_action_card_bilder_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    sl<HomeBloc>().add(HomeEventInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        actions: [SwitchThemeWidget()],
      ),
      body: BlocProvider.value(
        value: sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return CustomScrollView(slivers: [SliverFillRemaining(child: LoadingWidget())]);
            } else if (state is HomeLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverFloatingHeader(
                    snapMode: FloatingHeaderSnapMode.overlay,
                    child: Padding(
                      padding: PaddingResources.screenSidesPadding,
                      child: SearchBarWidget(
                        enabled: false,
                        heroTag: 'home_search_bar',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.search.name,
                            extra: SearchViewArguments(heroTag: 'home_search_bar'),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: PaddingResources.screenSidesPadding,
                    sliver: HomeCardsBuilderWidget(cards: state.cards, units: state.units),
                  ),
                ],
              );
            } else if (state is HomeError) {
              return CustomScrollView(
                slivers: [SliverFillRemaining(child: Center(child: Text(state.message)))],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
