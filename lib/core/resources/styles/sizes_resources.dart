import 'package:flutter/material.dart';

class SizesResources {
  static const double sidePadding = sizeUnit * 12;

  ///
  static const double sizeUnit = 2;
  //
  static const double buttonSmallHeight = 38;
  static const double buttonMediumHeight = 44;
  static const double buttonLargeHeight = 55;
  //
  static const double iconButtonAppBarHeight = 48;
  static const double iconAppBarHeight = 18;

  //
  static double mainWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width - sidePadding;
  }

  static double mainHalfWidth(BuildContext context) {
    return (MediaQuery.sizeOf(context).width - (sidePadding * 2)) / 2;
  }

  static double mainQuarterWidth(BuildContext context) {
    return (MediaQuery.sizeOf(context).width - (sidePadding * 2)) / 4;
  }

  static double mainThreeQuarterWidth(BuildContext context) {
    return ((MediaQuery.sizeOf(context).width - (sidePadding)) / 4) * 3;
  }

  //
}
