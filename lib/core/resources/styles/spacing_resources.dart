import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

///
class Paddings {
  const Paddings();

  static EdgeInsets get screenSidesPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s8, vertical: 0);
  }

  static EdgeInsets get bottomButtonPadding {
    return EdgeInsets.symmetric(
      horizontal: screenSidesPadding.horizontal,
      vertical: SpacesResources.s6,
    );
  }

  static EdgeInsets get screenBodyPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s8, vertical: SpacesResources.s8);
  }

  static EdgeInsets get snackbarPadding {
    return EdgeInsets.symmetric(
      horizontal: SpacesResources.s1,
      vertical: SpacesResources.s1,
    );
  }

  static EdgeInsets screenTopPadding(BuildContext context) {
    return EdgeInsets.only(top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top);
  }

  static EdgeInsets get listViewPadding {
    return const EdgeInsets.only(top: SpacesResources.s4, bottom: SpacesResources.s80);
  }

  static EdgeInsets get fieldContentPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s8, vertical: SpacesResources.s8);
  }

  static EdgeInsets get searchBarPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s4);
  }

  static EdgeInsets get cardLessonPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s8, vertical: SpacesResources.s8);
  }

  static EdgeInsets get cardMediumPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s7);
  }

  static EdgeInsets get cardSmallPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s4);
  }

  static EdgeInsets get bottomSheetActionsPadding {
    return EdgeInsets.only(
      bottom: SpacesResources.s8,
      left: screenSidesPadding.left,
      right: screenSidesPadding.right,
    );
  }

  static EdgeInsets get statChipPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s6, horizontal: SpacesResources.s6);
  }

  static EdgeInsets get questionImagePadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s7);
  }

  static EdgeInsets get questionCardPadding {
    return const EdgeInsets.symmetric(
      horizontal: SpacesResources.s10,
      vertical: SpacesResources.s7,
    );
  }

  static EdgeInsets get cardLargePadding {
    return const EdgeInsets.symmetric(
      horizontal: SpacesResources.s8,
      vertical: SpacesResources.s10,
    );
  }

  static EdgeInsets get quoteOfTheDayCardPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s4);
  }

  static EdgeInsets get fullTestCardPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s3);
  }

  static EdgeInsets get switchCardPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s1);
  }

  static EdgeInsets get chipCardPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s1);
  }

  static EdgeInsets get cardMediumTitlePadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s4);
  }

  static EdgeInsets get cardTopResultsPadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s2, horizontal: SpacesResources.s4);
  }

  static EdgeInsets get cardLargeTitlePadding {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s6);
  }

  static EdgeInsets get dialog {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s8);
  }

  static EdgeInsets get dialogBody {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s2, vertical: SpacesResources.s4);
  }

  static EdgeInsets get dialogInset {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s16);
  }

  static EdgeInsets customPadding(int h, int v) {
    return EdgeInsets.symmetric(
      horizontal: SpacesResources.s1 * h,
      vertical: SpacesResources.s1 * v,
    );
  }

  static EdgeInsets get splashScreenPadding {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s8, vertical: SpacesResources.s8);
  }

  static EdgeInsets get modalBottomSheetPadding {
    return const EdgeInsets.only(
      right: SpacesResources.s4,
      left: SpacesResources.s4,
      top: SpacesResources.s2,
      bottom: SpacesResources.s6,
    );
  }

  static EdgeInsets get zero {
    return EdgeInsets.zero;
  }
}

///
class Margins {
  const Margins();

  static EdgeInsets get textFieldMargin {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s2, horizontal: SpacesResources.s0);
  }

  static EdgeInsets get statChipMargin {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s2, horizontal: SpacesResources.s1);
  }

  static EdgeInsets get questionImageMargin {
    return const EdgeInsets.symmetric(horizontal: SpacesResources.s6, vertical: SpacesResources.s7);
  }

  static EdgeInsets get quoteOfTheDayCardMargin {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s6);
  }

  static EdgeInsets get cardMargin {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s2);
  }

  static EdgeInsets get snackbarMargin {
    return EdgeInsets.only(
      right: Paddings.screenSidesPadding.right,
      left: Paddings.screenSidesPadding.left,
      bottom: SpacesResources.s4,
    );
  }

  static EdgeInsets get optionCardMargin {
    return const EdgeInsets.only(bottom: SpacesResources.s2);
  }

  static EdgeInsets get questionsCardMargin {
    return const EdgeInsets.symmetric(vertical: SpacesResources.s6);
  }

  static EdgeInsets customMargin(int h, int v) {
    return EdgeInsets.symmetric(
      horizontal: SpacesResources.s1 * h,
      vertical: SpacesResources.s1 * v,
    );
  }

  static EdgeInsets get zero {
    return EdgeInsets.zero;
  }
}

///
class SizedBoxes {
  const SizedBoxes();

  static SizedBox get s2h {
    return SizedBox(width: SpacesResources.s2);
  }

  static SizedBox get s4h {
    return SizedBox(width: SpacesResources.s4);
  }

  static SizedBox get s6h {
    return SizedBox(width: SpacesResources.s6);
  }

  static SizedBox get s8h {
    return SizedBox(width: SpacesResources.s8);
  }

  static SizedBox get s10h {
    return SizedBox(width: SpacesResources.s10);
  }

  ///

  static SizedBox get s2v {
    return SizedBox(height: SpacesResources.s2);
  }

  static SizedBox get s4v {
    return SizedBox(height: SpacesResources.s4);
  }

  static SizedBox get s6v {
    return SizedBox(height: SpacesResources.s6);
  }

  static SizedBox get s8v {
    return SizedBox(height: SpacesResources.s8);
  }

  static SizedBox get s10v {
    return SizedBox(height: SpacesResources.s10);
  }
}
