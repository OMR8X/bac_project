import 'package:flutter/material.dart';

class OptionCardColors extends ThemeExtension<OptionCardColors> {
  final Color borders;
  final Color bordersCorrect;
  final Color bordersIncorrect;
  final Color bordersNotes;
  final Color background;
  final Color backgroundCorrect;
  final Color backgroundIncorrect;
  final Color backgroundNotes;
  final Color text;
  final Color textCorrect;
  final Color textIncorrect;
  final Color textNotes;

  OptionCardColors({
    required this.borders,
    required this.bordersCorrect,
    required this.bordersIncorrect,
    required this.bordersNotes,
    required this.background,
    required this.backgroundCorrect,
    required this.backgroundIncorrect,
    required this.backgroundNotes,
    required this.text,
    required this.textCorrect,
    required this.textIncorrect,
    required this.textNotes,
  });

  @override
  OptionCardColors copyWith({
    Color? borders,
    Color? bordersCorrect,
    Color? bordersIncorrect,
    Color? bordersNotes,
    Color? background,
    Color? backgroundCorrect,
    Color? backgroundIncorrect,
    Color? backgroundNotes,
    Color? text,
    Color? textCorrect,
    Color? textIncorrect,
    Color? textNotes,
  }) {
    return OptionCardColors(
      borders: borders ?? this.borders,
      bordersCorrect: bordersCorrect ?? this.bordersCorrect,
      bordersIncorrect: bordersIncorrect ?? this.bordersIncorrect,
      bordersNotes: bordersNotes ?? this.bordersNotes,
      background: background ?? this.background,
      backgroundCorrect: backgroundCorrect ?? this.backgroundCorrect,
      backgroundIncorrect: backgroundIncorrect ?? this.backgroundIncorrect,
      backgroundNotes: backgroundNotes ?? this.backgroundNotes,
      text: text ?? this.text,
      textCorrect: textCorrect ?? this.textCorrect,
      textIncorrect: textIncorrect ?? this.textIncorrect,
      textNotes: textNotes ?? this.textNotes,
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
      bordersNotes: Color.lerp(bordersNotes, other.bordersNotes, t) ?? bordersNotes,
      background: Color.lerp(background, other.background, t) ?? background,
      backgroundCorrect:
          Color.lerp(backgroundCorrect, other.backgroundCorrect, t) ?? backgroundCorrect,
      backgroundIncorrect:
          Color.lerp(backgroundIncorrect, other.backgroundIncorrect, t) ?? backgroundIncorrect,
      backgroundNotes: Color.lerp(backgroundNotes, other.backgroundNotes, t) ?? backgroundNotes,
      text: Color.lerp(text, other.text, t) ?? text,
      textCorrect: Color.lerp(textCorrect, other.textCorrect, t) ?? textCorrect,
      textIncorrect: Color.lerp(textIncorrect, other.textIncorrect, t) ?? textIncorrect,
      textNotes: Color.lerp(textNotes, other.textNotes, t) ?? textNotes,
    );
  }
}
