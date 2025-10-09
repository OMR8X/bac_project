import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/color_extensions.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../styles/font_styles_manager.dart';
import '../styles/sizes_resources.dart';
import 'extensions/success_colors.dart';

class AppLightTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppFontStyles.fontFamily,
      // textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorsResourcesLight.primary,
        primaryContainer: ColorsResourcesLight.primaryContainer,
        onPrimary: ColorsResourcesLight.onPrimary,
        onPrimaryContainer: ColorsResourcesLight.onPrimaryContainer,
        secondary: ColorsResourcesLight.secondary,
        secondaryContainer: ColorsResourcesLight.secondaryContainer,
        onSecondary: ColorsResourcesLight.onSecondary,
        onSecondaryContainer: ColorsResourcesLight.onSecondaryContainer,

        tertiary: ColorsResourcesLight.tertiary,
        tertiaryContainer: ColorsResourcesLight.tertiaryContainer,
        onTertiary: ColorsResourcesLight.onTertiary,
        onTertiaryContainer: ColorsResourcesLight.onTertiaryContainer,
        error: ColorsResourcesLight.error,
        errorContainer: ColorsResourcesLight.errorContainer,
        onError: ColorsResourcesLight.onError,

        //
        surface: ColorsResourcesLight.surface,
        onSurface: ColorsResourcesLight.onSurface,

        surfaceContainerLowest: ColorsResourcesLight.containerColors.surfaceContainerLowest,
        surfaceContainerLow: ColorsResourcesLight.containerColors.surfaceContainerLow,
        surfaceContainer: ColorsResourcesLight.containerColors.surfaceContainer,
        surfaceContainerHigh: ColorsResourcesLight.containerColors.surfaceContainerHigh,
        surfaceContainerHighest: ColorsResourcesLight.containerColors.surfaceContainerHighest,
        onSurfaceVariant: ColorsResourcesLight.onSurfaceVariant,
        //
        outline: ColorsResourcesLight.outline,
        outlineVariant: ColorsResourcesLight.outlineVariant,
        //
        shadow: ColorsResourcesLight.shadow,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SkeletonizerConfigData(
          containersColor: ColorsResourcesLight.surface,
          switchAnimationConfig: SwitchAnimationConfig(
            duration: Duration(milliseconds: 1000),
          ),
        ),
        SuccessColors(
          success: ColorsResourcesLight.success,
          onSuccess: ColorsResourcesLight.onSuccess,
          successContainer: ColorsResourcesLight.successContainer,
        ),
        ExtraColors(
          blue: ColorsResourcesLight.blue,
          green: ColorsResourcesLight.green,
          yellow: ColorsResourcesLight.yellow,
          orange: ColorsResourcesLight.orange,
          pink: ColorsResourcesLight.pink,
          red: ColorsResourcesLight.error,
          primaryState: ColorsResourcesLight.primaryState,
        ),
        OptionCardColors(
          borders: ColorsResourcesLight.outlineVariant,
          bordersCorrect: ColorsResourcesLight.success.withAlpha(100),
          bordersIncorrect: ColorsResourcesLight.error.withAlpha(100),
          bordersNotes: ColorsResourcesLight.warning.withAlpha(100),
          background: ColorsResourcesLight.containerColors.surfaceContainerLowest,
          backgroundCorrect: ColorsResourcesLight.successContainer.withAlpha(50),
          backgroundIncorrect: ColorsResourcesLight.errorContainer.withAlpha(50),
          backgroundNotes: ColorsResourcesLight.warningContainer.withAlpha(50),
          text: ColorsResourcesLight.onSurface,
          textCorrect: ColorsResourcesLight.success.darker(0.5),
          textIncorrect: ColorsResourcesLight.error.darker(0.5),
          textNotes: ColorsResourcesLight.onWarning.darker(0.5),
        ),
      ],
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStylesResources.cardMediumTitle.copyWith(
          color: ColorsResourcesLight.onSurface,
        ),
        subtitleTextStyle: TextStylesResources.cardMediumSubtitle.copyWith(
          color: ColorsResourcesLight.onSurfaceVariant,
        ),
      ),

      ///
      popupMenuTheme: PopupMenuThemeData(
        elevation: 0.5,
        labelTextStyle: WidgetStatePropertyAll(
          TextStylesResources.cardSmallSubtitle.copyWith(color: ColorsResourcesLight.onSurface),
        ),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.buttonBorderRadius,
          side: BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
        ),
      ),

      ///
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.onPrimary;
          }
          return ColorsResourcesLight.primaryContainer;
        }),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.primaryContainer;
        }),
      ),

      ///
      chipTheme: ChipThemeData(
        // Unselected text
        labelStyle: TextStylesResources.chipLabelStyle.copyWith(
          color: ColorsResourcesLight.primary,
        ),
        // Selected text
        secondaryLabelStyle: TextStylesResources.chipLabelStyle.copyWith(
          color: ColorsResourcesLight.primaryContainer,
        ),
        checkmarkColor: ColorsResourcesLight.primaryContainer,
        selectedColor: ColorsResourcesLight.primaryContainer,
        color: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.containerColors.surfaceContainer;
        }),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        side: BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
      ),

      ///
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primaryContainer;
          }
          return ColorsResourcesLight.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.containerColors.surfaceContainerLowest;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.outline;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // Add more properties if needed
        padding: Paddings.zero, // As you already set
      ),

      ///

      ///
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesLight.primary,
        foregroundColor: Colors.white,
      ),

      ///
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsResourcesLight.containerColors.surfaceContainerLowest,
        insetPadding: Paddings.dialogInset,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.dialogBorderRadius),
      ),

      ///
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        color: ColorsResourcesLight.containerColors.surfaceContainerLowest,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(
            color: ColorsResourcesLight.outlineVariant,
            width: SizesResources.cardMediumBorderWidth,
          ),
        ),
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            ColorsResourcesLight.containerColors.surfaceContainerLowest,
          ),
          alignment: Alignment.topCenter,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadiusResource.fieldBorderRadius),
          ),
        ),
      ),

      /// [BUTTONS]
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.primaryState[100],
          foregroundColor: ColorsResourcesLight.primaryState[800],
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          side: BorderSide(
            color: ColorsResourcesLight.outline,
            width: SizesResources.buttonBorderWidth,
          ),
        ),
      ),

      ///
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: ColorsResourcesLight.primary,
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button.copyWith(color: ColorsResourcesLight.primary),
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
        ),
      ),

      ///
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.primary,
          foregroundColor: ColorsResourcesLight.primaryContainer,
          disabledBackgroundColor: ColorsResourcesLight.primaryContainer.withAlpha(100),
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadiusResource.buttonBorderRadius,
            side: BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
          ),
          textStyle: TextStylesResources.button,
        ),
      ),

      ///
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.containerColors.surfaceContainerLowest,
          foregroundColor: ColorsResourcesLight.onSurface,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
          side: BorderSide(color: ColorsResourcesLight.outlineVariant),
        ),
      ),

      ///
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          alignment: Alignment.center,
          padding: Paddings.zero,
          minimumSize: Size(
            SizesResources.iconButtonAppBarHeight,
            SizesResources.iconButtonAppBarHeight,
          ),
          backgroundColor: ColorsResourcesLight.surface,
          foregroundColor: ColorsResourcesLight.onSurface,
          shape: RoundedSuperellipseBorder(
            side: BorderSide(
              color: ColorsResourcesLight.outlineVariant,
              width: SizesResources.iconButtonBorderWidth,
            ),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
        ),
      ),

      ///
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsResourcesLight.surface,
        shadowColor: Colors.transparent,
        actionsPadding: Paddings.screenSidesPadding,
        titleTextStyle: TextStylesResources.appBar.copyWith(color: ColorsResourcesLight.onSurface),
        surfaceTintColor: Colors.transparent,
        leadingWidth: SizesResources.iconButtonAppBarHeight + Paddings.screenSidesPadding.right,
        foregroundColor: ColorsResourcesLight.onSurfaceVariant,
        centerTitle: true,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          minimumSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          fixedSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          maximumSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          side: WidgetStatePropertyAll(BorderSide(color: ColorsResourcesLight.outline)),
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.fieldBorderRadius),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: ColorsResourcesLight.containerColors.surfaceContainerLow,

          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: BorderSide(
              color: ColorsResourcesLight.outline,
              width: SizesResources.fieldBorderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: BorderSide(
              color: ColorsResourcesLight.outline,
              width: SizesResources.fieldBorderWidth,
            ),
          ),
          contentPadding: Paddings.fieldContentPadding,
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorsResourcesLight.containerColors.surfaceContainerLow,

        labelStyle: TextStylesResources.textField.copyWith(
          color: ColorsResourcesLight.onSurfaceVariant,
        ),
        helperStyle: TextStylesResources.textFieldHelper.copyWith(
          color: ColorsResourcesLight.onSurfaceVariant,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesLight.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesLight.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesLight.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadiusResource.fieldBorderRadius,
        //   borderSide: const BorderSide(color: ColorsResourcesLight.outline,width: 0..20),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesLight.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        outlineBorder: BorderSide(color: ColorsResourcesLight.outline),
        contentPadding: Paddings.fieldContentPadding,
      ),
    );
  }
}
