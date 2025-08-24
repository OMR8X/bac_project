import 'package:flutter/material.dart';

/// Manages font families and provides unified text styles.
class AppFontStyles {
  static const String fontFamily = 'IBM';

  static TextStyle makeFontStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );
  }
}

/// Defines consistent font weight values.
class FontWeightResources {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight extraBold = FontWeight.w700;
  static const FontWeight black = FontWeight.w800;
}

/// Defines consistent font size values.
class FontSizeResources {
  static const double s8 = 8.0;
  static const double s9 = 9.0;
  static const double s10 = 10.0;
  static const double s11 = 11.0;
  static const double s12 = 12.0;
  static const double s13 = 13.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s19 = 19.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
}

/// Provides themed and reusable text styles.
class AppTextStyles {
  // Headings
  static const TextStyle largeTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s24,
    fontWeight: FontWeightResources.bold,
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s20,
    fontWeight: FontWeightResources.bold,
  );

  static const TextStyle title = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s14,
    fontWeight: FontWeightResources.medium,
  );
  static const TextStyle chipLabelStyle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.bold,
  );
  static const TextStyle cardLargeTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s19,
    fontWeight: FontWeightResources.medium,
  );
  static const TextStyle cardMediumTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s14,
    fontWeight: FontWeightResources.bold,
  );
  static const TextStyle cardMediumSubtitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.regular,
  );
  static const TextStyle cardSmallTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.medium,
  );

  static const TextStyle cardSmallSubtitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.regular,
  );
  static const TextStyle subTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.regular,
  );
  // testing

  static const TextStyle questionsTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s14,

    height: 2,
    fontWeight: FontWeightResources.regular,
  );
  static const TextStyle optionsTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.regular,
  );

  // Captions & Labels
  static const TextStyle caption = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s10,
    fontWeight: FontWeightResources.light,
  );

  static const TextStyle miniCaption = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s8,
    fontWeight: FontWeightResources.medium,
  );

  static const TextStyle linkText = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.medium,
    color: Colors.cyan,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.regular,
    color: Colors.red,
  );

  // Notification Styles
  static const TextStyle notificationTitle = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s14,
    fontWeight: FontWeightResources.black,
  );

  static const TextStyle notificationBody = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontSize: FontSizeResources.s12,
    fontWeight: FontWeightResources.medium,
    height: 1.5,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.bold,
    fontSize: FontSizeResources.s12,
  );

  static const TextStyle menuButton = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.medium,
    fontSize: FontSizeResources.s12,
  );

  static const TextStyle boxedButton = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.black,
    fontSize: FontSizeResources.s12,
  );

  static const TextStyle underButton = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.regular,
    fontSize: FontSizeResources.s10,
  );

  // TextFields
  static const TextStyle textField = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.regular,
    fontSize: FontSizeResources.s14,
  );
  static const TextStyle textFieldHelper = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.regular,
    fontSize: FontSizeResources.s10,
  );

  // AppBar
  static const TextStyle appBar = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.bold,
    fontSize: FontSizeResources.s19,
  );
  // AppBarAction
  static const TextStyle appBarAction = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.bold,
    fontSize: FontSizeResources.s19,
  );
  // bottomNavigationBarLabel
  static const TextStyle bottomNavigationBarLabel = TextStyle(
    fontFamily: AppFontStyles.fontFamily,
    fontWeight: FontWeightResources.medium,
    fontSize: FontSizeResources.s10,
  );
}
