import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredItemWrapperWidget extends StatelessWidget {
  const StaggeredItemWrapperWidget({super.key, required this.child, required this.position});
  final int position;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: position,
      duration: const Duration(milliseconds: 180),
      child: ScaleAnimation(
        scale: 0.99,
        curve: Curves.easeOutCirc,
        child: SlideAnimation(
          verticalOffset: 1.0,
          curve: Curves.easeOut,
          child: child,
        ),
      ),
    );
  }
}
