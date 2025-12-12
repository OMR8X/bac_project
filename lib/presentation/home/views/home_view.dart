import 'dart:math';

import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/core/widgets/messages/snackbars/informations_snackbar_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/notifications_icon_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/search_icon_widget.dart';
import 'package:bac_project/features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:bac_project/features/settings/other/fake_quotes_list.dart';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart';
import 'package:bac_project/presentation/home/widgets/quote_of_the_day_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/services/router/routes.dart';
import '../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';
import '../../../features/tests/domain/entities/unit.dart';
import '../../notifications/state/explore_notifications/notifications_bloc.dart';
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
    sl<NotificationsBloc>().add(SyncNotificationsEvent());
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
              context.pushNamed(
                Routes.search.name,
                queryParameters: SearchViewArguments(unitId: null).toQueryParameters(),
              );
            },
          ),

          if (kDebugMode) SwitchThemeIconWidget(),
        ],
      ),
      body: BlocProvider.value(
        value: sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return _LoadingView();
            } else if (state is HomeLoaded) {
              return _LoadedView(state: state);
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

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.state});

  final HomeLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.screenSidesPadding,
      child: CustomScrollView(
        slivers: [
          // SliverPadding(
          //   padding: EdgeInsetsGeometry.only(top: Paddings.listViewPadding.top),
          //   sliver: SliverFloatingHeader(
          //     snapMode: FloatingHeaderSnapMode.overlay,
          //     child: QuoteOfTheDayWidget(
          //       quote: fakeQuotes[Random().nextInt(fakeQuotes.length - 1)],
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: Paddings.listViewPadding,
            sliver: HomeCardsBuilderWidget(units: state.units),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Theme.of(context).colorScheme.surface,
      child: _LoadedView(
        state: HomeLoaded(
          units: List.generate(10, (index) => Unit.mock()),
        ),
      ),
    );
  }
}
