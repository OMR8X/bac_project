import 'package:bac_project/core/services/localization/localization_keys.dart';
import 'package:bac_project/core/services/localization/localization_manager.dart';
import 'package:bac_project/core/widgets/ui/custom_action_card_widget.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocalizationManager().get(LocalizationKeys.home.title))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              onChanged: (value) {
                // Handle search text changes
              },
              onFieldSubmitted: (value) {
                // Handle search submission
              },
            ),
          ),
          CustomActionCardWidget(
            title: LocalizationManager().get(LocalizationKeys.home.card.title),
            subtitle: LocalizationManager().get(LocalizationKeys.home.card.subtitle),
            firstButtonText: LocalizationManager().get(LocalizationKeys.home.card.firstButtonText),
            secondButtonText: LocalizationManager().get(LocalizationKeys.home.card.secondButtonText),
            onFirstPressed: () {},
            onSecondPressed: () {},
          ),
        ],
      ),
    );
  }
}
