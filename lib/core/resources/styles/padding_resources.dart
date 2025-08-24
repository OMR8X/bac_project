import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

class PaddingResources {
  ///
  static const sizeUnit = SizesResources.sizeUnit;

  ///
  static const EdgeInsets screenSidesPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s4,
    vertical: 0,
  );

  ///
  static const EdgeInsets listViewPadding = EdgeInsets.only(
    top: SpacesResources.s4,
    bottom: SpacesResources.s80,
  );

  ///
  static const EdgeInsets textFieldMargin = EdgeInsets.symmetric(
    vertical: SpacesResources.s2,
    horizontal: SpacesResources.s0,
  );

  ///
  static const EdgeInsets fieldContentPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s6,
    vertical: SpacesResources.s6,
  );

  ///
  static const EdgeInsets searchBarPadding = EdgeInsets.symmetric(vertical: SpacesResources.s4);

  ///
  static const EdgeInsets cardLessonInnerPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s8,
    vertical: SpacesResources.s8,
  );

  ///
  static const EdgeInsets cardMediumInnerPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s6,
    vertical: SpacesResources.s7,
  );

  ///
  static const EdgeInsets questionCardInnerPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s10,
    vertical: SpacesResources.s7,
  );

  ///
  static const EdgeInsets cardLargeInnerPadding = EdgeInsets.symmetric(
    horizontal: SpacesResources.s8,
    vertical: SpacesResources.s10,
  );

  ///
  static const EdgeInsets cardOuterPadding = EdgeInsets.symmetric(vertical: SpacesResources.s2);

  ///
  static const EdgeInsets fullTestCardPadding = EdgeInsets.symmetric(vertical: SpacesResources.s4);

  ///
  static const EdgeInsets switchCardInnerPadding = EdgeInsets.symmetric(
    vertical: SpacesResources.s1,
  );

  ///
  static const EdgeInsets chipCardInnerPadding = EdgeInsets.symmetric(vertical: SpacesResources.s1);

  ///
  static const EdgeInsets cardMediumTitlePadding = EdgeInsets.symmetric(
    vertical: SpacesResources.s4,
  );
  static const EdgeInsets cardLargeTitlePadding = EdgeInsets.symmetric(
    vertical: SpacesResources.s6,
  );
  static const EdgeInsets bottomButtonPadding = EdgeInsets.symmetric(
    vertical: SpacesResources.s2,
    horizontal: SpacesResources.s2,
  );

  ///
  static const EdgeInsets optionCardMargin = EdgeInsets.only(bottom: SpacesResources.s2);

  ///
  static const EdgeInsets questionsCardMargin = EdgeInsets.symmetric(vertical: SpacesResources.s6);

  ///
  static EdgeInsets customPadding(int h, int v) =>
      EdgeInsets.symmetric(horizontal: SpacesResources.s1 * h, vertical: SpacesResources.s1 * v);
}
