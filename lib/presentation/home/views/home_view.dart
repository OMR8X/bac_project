import 'package:bac_project/core/widgets/ui/custom_action_card_widget.dart';
import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:bac_project/presentation/home/widgets/home_card_bilder_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home View")),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: HomeCardsBuilderWidget(),
            ),
          ),

        ],
      ),
    );
  }
}
