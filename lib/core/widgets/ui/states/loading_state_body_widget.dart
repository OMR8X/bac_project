import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingStateBodyWidget extends StatelessWidget {
  const LoadingStateBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Paddings.screenBodyPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CupertinoActivityIndicator()],
          ),
        ),
      ),
    );
  }
}
