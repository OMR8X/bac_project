
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/ui/loading_widget.dart';
import '../../../core/widgets/ui/search_bar_widget.dart';
import '../blocs/home_bloc.dart';
import '../widgets/home_action_card_bilder_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(LocalizationManager().get(LocalizationKeys.home.title)),
      // ),
      body: BlocProvider.value(
        value: HomeBloc()..add(HomeEventInitialize()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const LoadingWidget();
            } else if (state is HomeLoaded) {
              return SafeArea(
                child: Padding(
                  padding: PaddingResources.screenSidesPadding,
                  child: Column(
                    children: [
                      // MotivationalQuoteCardWidget(
                      //   quote:
                      //       "النجاح هو نتيجة الإعداد الجيد والعمل الشاق والتعلم من الفشل",
                      //   author: "كولن باول",
                      //   icon: Icons.lightbulb_outline,
                      //   onTap: () {},
                      // ),
                      Padding(
                        padding: PaddingResources.searchBarPadding,
                        child: SearchBarWidget(
                          onChanged: (value) {
                            // Handle search
                          },
                        ),
                      ),
                      Expanded(
                        child: HomeCardsBuilderWidget(
                          cards: state.cards,
                          units: state.units,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
