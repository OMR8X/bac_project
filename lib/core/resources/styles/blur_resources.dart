import 'dart:ui';

import 'package:flutter/material.dart';

class BlurResources {
  static ImageFilter buttonBlur(BuildContext context) {
    return ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0);
  }

  static ImageFilter bottomNavigationBarBlur(BuildContext context) {
    return ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  }

  static ImageFilter fullUnTestCardBlur(BuildContext context) {
    return ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  }
}
