import 'package:flutter/material.dart';

class AppTransitions {
  ///
  static const Duration transitionDuration = Duration(milliseconds: 180);
  static const Duration reverseTransitionDuration = Duration(milliseconds: 80);

  ///
  static Widget commonTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final fadeCurve = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    final slideCurve = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    final scaleCurve = CurvedAnimation(parent: animation, curve: Curves.easeOutCirc);
    return FadeTransition(
      opacity: Tween<double>(begin: 0.1, end: 1.0).animate(fadeCurve),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1.0).animate(scaleCurve),
        child: child,
      ),
    );
  }

  ///
  static Widget noAnimationsTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
