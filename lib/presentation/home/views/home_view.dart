import 'package:bac_project/core/widgets/ui/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home View")),
      body: Padding(
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
    );
  }
}
