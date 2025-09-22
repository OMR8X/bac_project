import 'package:flutter/material.dart';

class OptionCardColors extends ThemeExtension<OptionCardColors> {
  final Color borders;
  final Color bordersCorrect;
  final Color bordersIncorrect;
  final Color background;
  final Color backgroundCorrect;
  final Color backgroundIncorrect;
  final Color text;
  final Color textCorrect;
  final Color textIncorrect;

  OptionCardColors({
    required this.borders,
    required this.bordersCorrect,
    required this.bordersIncorrect,
    required this.background,
    required this.backgroundCorrect,
    required this.backgroundIncorrect,
    required this.text,
    required this.textCorrect,
    required this.textIncorrect,
  });

  @override
  OptionCardColors copyWith({
    Color? borders,
    Color? bordersCorrect,
    Color? bordersIncorrect,
    Color? background,
    Color? backgroundCorrect,
    Color? backgroundIncorrect,
    Color? text,
    Color? textCorrect,
    Color? textIncorrect,
  }) {
    return OptionCardColors(
      borders: borders ?? this.borders,
      bordersCorrect: bordersCorrect ?? this.bordersCorrect,
      bordersIncorrect: bordersIncorrect ?? this.bordersIncorrect,
      background: background ?? this.background,
      backgroundCorrect: backgroundCorrect ?? this.backgroundCorrect,
      backgroundIncorrect: backgroundIncorrect ?? this.backgroundIncorrect,
      text: text ?? this.text,
      textCorrect: textCorrect ?? this.textCorrect,
      textIncorrect: textIncorrect ?? this.textIncorrect,
    );
  }

  @override
  OptionCardColors lerp(covariant ThemeExtension<OptionCardColors>? other, double t) {
    if (other is! OptionCardColors) {
      return this;
    }
    return OptionCardColors(
      borders: Color.lerp(borders, other.borders, t) ?? borders,
      bordersCorrect: Color.lerp(bordersCorrect, other.bordersCorrect, t) ?? bordersCorrect,
      bordersIncorrect: Color.lerp(bordersIncorrect, other.bordersIncorrect, t) ?? bordersIncorrect,
      background: Color.lerp(background, other.background, t) ?? background,
      backgroundCorrect:
          Color.lerp(backgroundCorrect, other.backgroundCorrect, t) ?? backgroundCorrect,
      backgroundIncorrect:
          Color.lerp(backgroundIncorrect, other.backgroundIncorrect, t) ?? backgroundIncorrect,
      text: Color.lerp(text, other.text, t) ?? text,
      textCorrect: Color.lerp(textCorrect, other.textCorrect, t) ?? textCorrect,
      textIncorrect: Color.lerp(textIncorrect, other.textIncorrect, t) ?? textIncorrect,
    );
  }
}
