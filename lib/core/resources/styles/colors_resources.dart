import 'package:flutter/material.dart';
import '../themes/extensions/container_colors.dart';

class ColorsResourcesLight {
  static const Color primary = Color(0xFF4648D4);
  static const Color onPrimary = Color(0xffF5F5F5);
  static const Color primaryContainer = Color(0xFFF3F3F3);
  static const Color onPrimaryContainer = Color(0xFF4648D4);
  //
  // static const Color primary = Color(0xFF2B267E);
  // static const Color primary = Color(0xFF695BDF);
  // static const Color primary = Color(0xFF5055D6);
  // static const Color primary = Color(0xFF572BF8);
  // static const Color primary = Color(0xFF3021AB);
  // static const Color primary = Color(0xFF33006f);
  //
  // static const Color primary = Color(0xFF33006f);
  // static const Color onPrimary = Color(0xFFFFFFFF);
  // static const Color primaryContainer = Color(0xFFF0F1FF);
  // static const Color onPrimaryContainer = Color(0xFF1A1A2E);
  //
  static const Color secondary = Color(0xff274A72);
  static const Color onSecondary = Color(0xffD0DFF0);
  static const Color secondaryContainer = Color(0xffF5F9FC);
  static const Color onSecondaryContainer = Color(0xff2B5586);
  //
  static const Color tertiary = Color(0xFFE5D5F0);
  static const Color onTertiary = Color(0xFF553B69);
  static const Color tertiaryContainer = Color(0xFFFBF7FC);
  static const Color onTertiaryContainer = Color(0xFFB577D6);
  //
  static const Color error = Color(0xffF15858);
  static const Color errorContainer = Color(0xffFDECEA);
  static const Color onError = Color(0xffFFEFF3);
  //
  static const Color success = Color(0xff00AE6F);
  static const Color successContainer = Color(0xffDCFFE5);
  static const Color onSuccess = Color(0xffDCFFE5);
  //
  static const Color warning = Color(0xffF1D258);
  static const Color warningContainer = Color(0xffFDFBE6);
  static const Color onWarning = Color(0xff965A1C);
  //
  static const Color surface = Color(0xffF9F9F9);
  static const Color onSurface = Color(0xFF494949);
  static const Color onBackground = Color(0xFF747474);
  // static const Color surface = Color(0xffF6F7FB);
  // static const Color onSurface = Color(0xFF292D46);
  // static const Color onBackground = Color(0xFF4E4D77);
  static const Color onSurfaceVariant = Color(0xff4D4E72);
  // static const Color onSurface = Color(0xff0A0A10);
  // static const Color onSurfaceVariant = Color(0xff717171);
  //
  // static const Color surfaceContainer = Color(0xffFFFFFF);
  // static const Color surfaceContainerHigh = Color(0xffE3E9EA);
  // static const Color surfaceContainerHighest = Color(0xffBDBDBD);
  //
  // static Color outline = primaryState[300]!;
  static const Color outline = Color(0xffE7E7F2);
  static const Color outlineVariant = Color(0xffF1F1F7);
  // maybe using version of outline variant : 0xffE7E7F2
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
  static ContainerColors containerColors = ContainerColors(
    surfaceContainerLowest: Color(0xffFAFAFD),
    surfaceContainerLow: Color(0xffF1F1FB),
    surfaceContainer: Color(0xffE9E9F9),
    surfaceContainerHigh: Color(0xffEBEBEB),
    surfaceContainerHighest: Color(0xffE6E6E6),
  );
  // //
  // static ContainerColors containerColors = ContainerColors(
  //   surfaceContainerLowest: Color(0xffFCFCFC),
  //   surfaceContainerLow: Color(0xffF6F6F6),
  //   surfaceContainer: Color(0xffF0F0F0),
  //   surfaceContainerHigh: Color(0xffEBEBEB),
  //   surfaceContainerHighest: Color(0xffE6E6E6),
  // );
}

class ColorsResourcesDark {
  //
  // static const Color primary = Color(0xffE6E6E6);
  // static const Color primaryContainer = Color(0xff373737);
  // static const Color onPrimary = Color(0xff0B0A10);
  // static const Color onPrimaryContainer = Color(0xFFE8E9FF);
  // //
  // very good
  static const Color primary = Color(0xFF8B8DFF);
  static const Color primaryContainer = Color(0xFF1A1B2E);
  static const Color onPrimary = Color(0xFF0B0A10);
  static const Color onPrimaryContainer = Color(0xFFE8E9FF);
  //
  static const Color secondary = Color(0xff366392);
  static const Color onSecondary = Color(0xffE8F2FA);
  static const Color secondaryContainer = Color(0xff1A2027);
  static const Color onSecondaryContainer = Color(0xffB5D2F9);
  //
  static const Color tertiary = Color(0xFFF9A8D4);
  static const Color onTertiary = Color(0xFF1A0A12);
  static const Color tertiaryContainer = Color(0xFF4A1D34);
  static const Color onTertiaryContainer = Color(0xFFFCE7F3);
  //
  static const Color error = Color(0xffFF8198);
  static const Color errorContainer = Color(0xffB05D6B);
  static const Color onError = Color(0xff251B1B);
  //
  static const Color success = Color(0xff00AE6F);
  static const Color successContainer = Color(0xff1CFDAB);
  static const Color onSuccess = Color(0xff1B2522);
  //
  static const Color surface = Color.fromARGB(255, 0, 0, 0);
  static const Color onSurface = Color(0xffF3F3F3);
  static const Color onSurfaceVariant = Color(0xff9E9E9F);
  //
  static const Color outline = Color.fromARGB(255, 39, 39, 39);
  static const Color outlineVariant = Color.fromARGB(255, 18, 18, 18);
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
  static ContainerColors containerColors = ContainerColors(
    surfaceContainerLowest: const Color(0xff050505),
    surfaceContainerLow: const Color(0xff0A0A0A),
    surfaceContainer: const Color(0xff0F0F0F),
    surfaceContainerHigh: const Color(0xff141414),
    surfaceContainerHighest: const Color(0xff1A1A1A),
  );
}
