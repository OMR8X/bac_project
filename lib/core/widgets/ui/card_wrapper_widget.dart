import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/shadows_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:flutter/material.dart';

class CardWrapperWidget extends StatelessWidget {
  const CardWrapperWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: ShadowsResources.cardShadows(context),
        color: Colors.transparent,
        borderRadius: BorderRadiusResource.bordersRadiusMedium,
      ),
      child: child,
    );
  }
}
