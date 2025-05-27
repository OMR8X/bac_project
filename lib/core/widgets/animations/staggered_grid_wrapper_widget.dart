import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredGridWrapperWidget extends StatelessWidget {
  const StaggeredGridWrapperWidget({super.key, required this.child, required this.position});
  final int position;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 2,
      position: position,
      child: ScaleAnimation(
        scale: 0.96,
        curve: Curves.easeOutCirc,
        child: FadeInAnimation(
          curve: Curves.easeOut,
          child: SlideAnimation(
            verticalOffset: 2.0,
            curve: Curves.easeOut,
            child: child,
          ),
        ),
      ),
    );
  }
}
