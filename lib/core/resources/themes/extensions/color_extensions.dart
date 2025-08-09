import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color darker([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    return Color.lerp(this, Colors.black, amount)!;
  }

  Color lighter([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    return Color.lerp(this, Colors.white, amount)!;
  }

  ({Color deep, Color light}) withValues() {
    return (deep: darker(0.2), light: lighter(0.2));
  }
}
