import 'package:flutter/material.dart';

class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color blue;
  final Color green;
  final Color yellow;
  final Color orange;
  final Color pink;
  final Color red;

  ExtraColors({
    required this.blue,
    required this.green,
    required this.yellow,
    required this.orange,
    required this.pink,
    required this.red,
  });

  @override
  ExtraColors copyWith({
    Color? blue,
    Color? green,
    Color? yellow,
    Color? orange,
    Color? pink,
    Color? red,
  }) {
    return ExtraColors(
      blue: blue ?? this.blue,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      orange: orange ?? this.orange,
      pink: pink ?? this.pink,
      red: red ?? this.red,
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
      red: Color.lerp(red, other.red, t) ?? red,
    );
  }
}
