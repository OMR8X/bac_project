import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:flutter/material.dart';

class AppFontStyles {
  static const String fontFamily = 'NotoSansArabic';
  static TextStyle makeFontStyle({double? fontSize, double? height, double? lettersSpacing, double? wordsSpacing, Color fontColor = const Color(0xffC0C0C0), FontWeight fontWeight = FontWeightResources.medium}) {
    return TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: fontColor, wordSpacing: wordsSpacing, letterSpacing: lettersSpacing, height: height);
  }
}

class FontStylesResources {
  ///
  static TextStyle tileLargeTitleStyle(BuildContext context) {
    //
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.titleText : ColorsResourcesLight.titleText;
    //
    return TextStyle(color: Theme.of(context).colorScheme.onSurface, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 13);
  }

  ///
  static TextStyle tileTitleStyle(BuildContext context) {
    //
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.titleText : ColorsResourcesLight.titleText;
    //
    return TextStyle(color: Theme.of(context).colorScheme.onSurface, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 11);
  }

  ///
  static TextStyle tileSubTitleStyle(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.subTitleText : ColorsResourcesLight.subTitleText;
    return TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 10);
  }

  ///
  static TextStyle miniSubTitleStyle(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.subTitleText : ColorsResourcesLight.subTitleText;
    return TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 8);
  }

  ///
  static TextStyle notificationTitleStyle(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.subTitleText : ColorsResourcesLight.subTitleText;
    return TextStyle(color: Theme.of(context).colorScheme.onSurface, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.black, fontSize: 13);
  }

  ///

  static TextStyle notificationSubTitleStyle(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark ? ColorsResourcesDark.subTitleText : ColorsResourcesLight.subTitleText;
    return TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 11, height: 1.5);
  }

  ///
  static const TextStyle buttonStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.bold, fontSize: 12);

  ///
  static const TextStyle menuButtonStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.medium, fontSize: 12);

  ///
  static const TextStyle boxedButtonStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.black, fontSize: 12);

  ///
  static const TextStyle underButtonStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.regular, fontSize: 10);

  ///
  static const TextStyle textFieldStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.bold, fontSize: 12);

  ///
  static const TextStyle appBarButtonStyle = TextStyle(fontFamily: AppFontStyles.fontFamily, fontWeight: FontWeightResources.bold, fontSize: 19);
}

class FontWeightResources {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w600;
  static const FontWeight extraBold = FontWeight.w700;
  static const FontWeight black = FontWeight.w800;
}

class FontSizeResources {
  static const double s8 = 8.0;
  static const double s9 = 9.0;
  static const double s10 = 10.0;
  static const double s11 = 11.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
}
