import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class PaddingResources {
  ///
  static const sizeUnit = SizesResources.sizeUnit;

  ///
  static const EdgeInsets padding_0_1 = EdgeInsets.symmetric(horizontal: 0, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_0_2 = EdgeInsets.symmetric(horizontal: 0, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_0_3 = EdgeInsets.symmetric(horizontal: 0, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_0_4 = EdgeInsets.symmetric(horizontal: 0, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_0_5 = EdgeInsets.symmetric(horizontal: 0, vertical: SpacesResources.s5);

  ///
  static const EdgeInsets padding_1_0 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: 0);

  ///
  static const EdgeInsets padding_1_1 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_1_2 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_1_3 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_1_4 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_1_5 = EdgeInsets.symmetric(horizontal: SpacesResources.s1, vertical: SpacesResources.s5);

  ///
  static const EdgeInsets padding_2_0 = EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: 0);

  ///
  static const EdgeInsets padding_2_1 = EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_2_2 = EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_2_3 = EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_2_4 = EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_3_0 = EdgeInsets.symmetric(horizontal: SpacesResources.s3, vertical: 0);

  ///
  static const EdgeInsets padding_3_1 = EdgeInsets.symmetric(horizontal: SpacesResources.s3, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_3_2 = EdgeInsets.symmetric(horizontal: SpacesResources.s3, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_3_3 = EdgeInsets.symmetric(horizontal: SpacesResources.s3, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_3_4 = EdgeInsets.symmetric(horizontal: SpacesResources.s3, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_4_0 = EdgeInsets.symmetric(horizontal: SpacesResources.s4, vertical: 0);

  ///
  static const EdgeInsets padding_4_1 = EdgeInsets.symmetric(horizontal: SpacesResources.s4, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_4_2 = EdgeInsets.symmetric(horizontal: SpacesResources.s4, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_4_3 = EdgeInsets.symmetric(horizontal: SpacesResources.s4, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_4_4 = EdgeInsets.symmetric(horizontal: SpacesResources.s4, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_5_0 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: 0.0);

  ///
  static const EdgeInsets padding_5_1 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: SpacesResources.s1);

  ///
  static const EdgeInsets padding_5_2 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: SpacesResources.s2);

  ///
  static const EdgeInsets padding_5_3 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: SpacesResources.s3);

  ///
  static const EdgeInsets padding_5_4 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: SpacesResources.s4);

  ///
  static const EdgeInsets padding_5_5 = EdgeInsets.symmetric(horizontal: SpacesResources.s5, vertical: SpacesResources.s5);

  ///
  static const EdgeInsets padding_6_6 = EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s6);

  ///
  static const EdgeInsets padding_7_7 = EdgeInsets.symmetric(horizontal: SpacesResources.s7, vertical: SpacesResources.s7);

  ///
  static EdgeInsets customPadding(int h, int v) => EdgeInsets.symmetric(horizontal: SpacesResources.s1 * h, vertical: SpacesResources.s1 * v);
}
