import 'package:flutter/material.dart';

class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color blue;
  final Color green;
  final Color yellow;
  final Color orange;
  final Color pink;

  ExtraColors({
    required this.blue,
    required this.green,
    required this.yellow,
    required this.orange,
    required this.pink,
  });

  @override
  ExtraColors copyWith({Color? blue, Color? green, Color? yellow, Color? orange, Color? pink}) {
    return ExtraColors(
      blue: blue ?? this.blue,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      orange: orange ?? this.orange,
      pink: pink ?? this.pink,
    );
  }

  @override
  ExtraColors lerp(covariant ThemeExtension<ExtraColors>? other, double t) {
    if (other is! ExtraColors) {
      return this;
    }
    return ExtraColors(
      blue: Color.lerp(blue, other.blue, t) ?? blue,
      green: Color.lerp(green, other.green, t) ?? green,
      yellow: Color.lerp(yellow, other.yellow, t) ?? yellow,
      orange: Color.lerp(orange, other.orange, t) ?? orange,
      pink: Color.lerp(pink, other.pink, t) ?? pink,
    );
  }
}
