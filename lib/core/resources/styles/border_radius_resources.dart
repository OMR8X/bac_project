import 'package:flutter/material.dart';

import 'sizes_resources.dart';

class BorderRadiusResource {
  //
  static const sizeUnit = SizesResources.sizeUnit;
  //

  ///
  //
  static final bordersRadiusTiny = BorderRadius.circular(2 * sizeUnit);
  static final bordersRadiusSmall = BorderRadius.circular(4 * sizeUnit);
  static final bordersRadiusMedium = BorderRadius.circular(6 * sizeUnit);
  static final bordersRadiusLarge = BorderRadius.circular(8 * sizeUnit);
  static final bordersRadiusXLarge = BorderRadius.circular(10 * sizeUnit);
  static final bordersRadiusXXLarge = BorderRadius.circular(12 * sizeUnit);
  //
  static final buttonBorderRadius = bordersRadiusSmall;
  //
  static final fieldBorderRadius = bordersRadiusMedium;
  //
  static final tileBorderRadius = bordersRadiusSmall;
  //
  static final tileBoxBorderRadius = bordersRadiusSmall;
  //
  static final iconBorderRadius = bordersRadiusSmall;
  //
  static final dialogBorderRadius = bordersRadiusLarge;
  //
  static final cardBorderRadius = bordersRadiusLarge;
  //
  static final optionCardBorderRadius = bordersRadiusTiny;
}
