import 'dart:math';

import 'package:flutter/material.dart';

class AppTransitions {
  ///
  static const Duration transitionDuration = Duration(milliseconds: 160);
  static const Duration reverseTransitionDuration = Duration(milliseconds: 80);

  ///
  static Widget commonTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
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
  static Widget noAnimationsTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  ///
  /// Circular expansion transition that starts as a circle and expands to fill the screen
  static Widget circularExpansionTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final screenSize = MediaQuery.of(context).size;

    final scaleCurve = CurvedAnimation(parent: animation, curve: Curves.easeOutCirc);
    final fadeCurve = CurvedAnimation(parent: animation, curve: Curves.easeOut);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CircularExpansionClipper(progress: scaleCurve.value, screenSize: screenSize),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(fadeCurve),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Custom clipper for circular expansion animation
class CircularExpansionClipper extends CustomClipper<Path> {
  final double progress;
  final Size screenSize;

  CircularExpansionClipper({required this.progress, required this.screenSize});

  @override
  Path getClip(Size size) {
    final center = Offset(screenSize.width / 2, screenSize.height / 2);
    final maxRadius =
        sqrt(screenSize.width * screenSize.width + screenSize.height * screenSize.height) / 2;
    final currentRadius = maxRadius * progress;

    final path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: currentRadius));
    return path;
  }

  @override
  bool shouldReclip(CircularExpansionClipper oldClipper) {
    return oldClipper.progress != progress || oldClipper.screenSize != screenSize;
  }
}
