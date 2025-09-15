import 'package:flutter/material.dart';

class ColorsResourcesLight {
  //
  static Color primary = primaryState[900]!;
  // static const Color primary = Color(0xff1E1E26);
  static Color primaryContainer = primaryState[100]!;
  // static const Color primaryContainer = Color(0xffEEEEEE);
  static const Color onPrimary = Color(0xffF5F5F5);
  //
  static const Color error = Color(0xffF15858);
  static const Color errorContainer = Color(0xffFDECEA);
  static const Color onError = Color(0xffFFEFF3);
  //
  static const Color success = Color(0xff00AE6F);
  static const Color onSuccess = Color(0xffDCFFE5);
  //
  static const Color surface = Color(0xffFFFFFF);
  static Color onSurface = primaryState[900]!;
  static Color onBackground = primaryState[700]!;
  static Color onSurfaceVariant = primaryState[500]!;
  // static const Color onSurface = Color(0xff0A0A10);
  // static const Color onSurfaceVariant = Color(0xff717171);
  //
  static const Color surfaceContainer = Color(0xffFFFFFF);
  static const Color surfaceContainerHigh = Color(0xffE3E9EA);
  static const Color surfaceContainerHighest = Color(0xffBDBDBD);
  //
  // static Color outline = primaryState[300]!;
  static const Color outline = Color(0xffE5E4E5);
  static const Color outlineVariant = Color(0xffF5F5F5);
  //
  static const Color shadow = Color(0xff1D212F);
  //
  static const Color titleText = Color(0xff000000);
  static const Color subTitleText = Color(0xff8A8A8E);
  //
  //
  static const Color blueTextSeed = Color(0xff0FA4E9);
  //
  static const Color greenTextSeed = Color(0xff079669);
  //
  static const Color orangeTextSeed = Color(0xffFBBF24);
  //
  static const Color blue = Color(0xff0FA4E9);
  static const Color green = Color(0xff079669);
  static const Color yellow = Color(0xffFBBF24);
  static const Color orange = Color(0xffFB6824);
  static const Color pink = Color(0xffFB24BE);
  //
  static MaterialColor primaryState = MaterialColor(0xFF717171, <int, Color>{
    50: Color(0xFFf8fafc),
    100: Color(0xFFf1f5f9),
    200: Color(0xFFe2e8f0),
    300: Color(0xFFcbd5e1),
    400: Color(0xFF94a3b8),
    500: Color(0xFF64748b),
    600: Color(0xFF475569),
    700: Color(0xFF334155),
    800: Color(0xFF1e293b),
    900: Color(0xFF0f172a),
  });
}

class ColorsResourcesDark {
  //
  static const Color primary = Color(0xffE6E6E6);
  static const Color primaryContainer = Color(0xff0B0C0E);
  static const Color onPrimary = Color(0xff0B0A10);
  //
  static const Color error = Color(0xffFF8198);
  static const Color errorContainer = Color(0xffB05D6B);
  static const Color onError = Color(0xff251B1B);
  //
  static const Color success = Color(0xff1CFDAB);
  static const Color onSuccess = Color(0xff1B2522);
  //
  static const Color surface = Color(0xff080808);
  static const Color onSurface = Color(0xffF3F3F3);
  static const Color onSurfaceVariant = Color(0xff9E9E9F);
  //
  static const Color surfaceContainer = Color(0xff080808);
  static const Color surfaceContainerHigh = Color(0xff1C1C1F);
  static const Color surfaceContainerHighest = Color(0xff1E1E1E);
  //
  static const Color outline = Color(0xff404040);
  static const Color outlineVariant = Color(0xff252525);
  //
  static const Color boldShadow = Color(0xffE3EEFF);
  static const Color lightShadow = Color(0xff080808);
  //
  static const Color titleText = Color(0xffFFFFFF);
  static const Color subTitleText = Color(0xff8D8D93);
  //
  static const Color blue = Color.fromARGB(255, 104, 207, 255);
  static const Color green = Color.fromARGB(255, 35, 247, 180);
  static const Color yellow = Color.fromARGB(255, 255, 210, 97);
  static const Color orange = Color.fromARGB(255, 255, 147, 96);
  static const Color pink = Color.fromARGB(255, 248, 105, 208);
  //
  static const MaterialColor primaryState = MaterialColor(0xFF717171, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF717171),
  });
}
