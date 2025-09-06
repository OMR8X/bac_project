import 'package:flutter/material.dart';

class DesigningView extends StatefulWidget {
  const DesigningView({super.key});

  @override
  State<DesigningView> createState() => _DesigningViewState();
}

class _DesigningViewState extends State<DesigningView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(children: [

        ],
      ),
    );
  }
}
