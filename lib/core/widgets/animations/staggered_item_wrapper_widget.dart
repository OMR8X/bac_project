import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredItemWrapperWidget extends StatelessWidget {
  const StaggeredItemWrapperWidget({super.key, required this.child, required this.position});
  final int position;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 220),
      child: FadeInAnimation(
        duration: const Duration(milliseconds: 220),
        child: ScaleAnimation(
          scale: 0.95,
          curve: Curves.easeOutCirc,
          child: SlideAnimation(verticalOffset: 5, curve: Curves.easeOut, child: child),
        ),
      ),
    );
  }
}
