import 'dart:math';

import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/ui/icons/notifications_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/search_icon_widget.dart';
import 'package:bac_project/features/settings/other/fake_quotes_list.dart';
import 'package:bac_project/presentation/home/widgets/quote_of_the_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/router/app_routes.dart';
import '../../../core/widgets/ui/loading_widget.dart';
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
        leading: NotificationsIconWidget(),
        actions: [
          SearchIconWidget(
            onPressed: () {
              context.pushNamed(AppRoutes.search.name, extra: SearchViewArguments(unitId: null));
            },
          ),
          //  SwitchThemeWidget()
        ],
      ),
      body: BlocProvider.value(
        value: sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return CustomScrollView(slivers: [SliverFillRemaining(child: LoadingWidget())]);
            } else if (state is HomeLoaded) {
              return Padding(
                padding: Paddings.screenSidesPadding,
                child: CustomScrollView(
                  slivers: [
                    SliverFloatingHeader(
                      snapMode: FloatingHeaderSnapMode.overlay,
                      child: QuoteOfTheDayWidget(
                        quote: fakeQuotes[Random().nextInt(fakeQuotes.length - 1)],
                      ),
                      // child: QuoteOfTheDayWidget(quote: sl<AppSettings>().motivationalQuote ?? fakeQuotes[Random().nextInt(fakeQuotes.length - 1)]),
                    ),

                    SliverPadding(
                      padding: Paddings.listViewPadding,
                      sliver: HomeCardsBuilderWidget(cards: state.cards, units: state.units),
                    ),
                  ],
                ),
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
