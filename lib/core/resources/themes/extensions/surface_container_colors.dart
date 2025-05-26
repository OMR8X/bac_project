import 'package:flutter/material.dart';

class SurfaceContainerColors extends ThemeExtension<SurfaceContainerColors> {
  final Color surfaceContainer;
  final Color surfaceContainerHigh;

  SurfaceContainerColors({
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
  });

  @override
  SurfaceContainerColors copyWith({
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
  }) {
    return SurfaceContainerColors(
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
    );
  }

  @override
  SurfaceContainerColors lerp(ThemeExtension<SurfaceContainerColors>? other, double t) {
    if (other is! SurfaceContainerColors) {
      return this;
    }
    return SurfaceContainerColors(
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t) ?? surfaceContainer,
      surfaceContainerHigh: Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t) ?? surfaceContainerHigh,
    );
  }
}
