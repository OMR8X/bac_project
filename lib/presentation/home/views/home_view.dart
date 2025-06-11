import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/core/widgets/ui/custom_action_card_widget.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:bac_project/presentation/home/widgets/home_action_card_bilder_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/padding_resources.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                title: Text(LocalizationManager().get(LocalizationKeys.home.title)),
                forceElevated: innerBoxIsScrolled,
              ),
            ],
        body: Padding(
          padding: PaddingResources.screenSidesPadding,
          child: Column(
            children: [
              SearchBarWidget(onChanged: (value) {}, onFieldSubmitted: (value) {}),
              const SizedBox(height: 10),
              Expanded(child: HomeCardsBuilderWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
