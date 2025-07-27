import 'package:flutter/material.dart';

import '../../../core/services/localization/localization_keys.dart';
import '../../../core/services/localization/localization_manager.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationManager().get(LocalizationKeys.result.title)),
      ),
      body: const Center(),
    );
  }
}
