import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/option_card_colors.dart';
import 'package:flutter/material.dart';
import '../styles/border_radius_resources.dart';
import '../styles/spacing_resources.dart';
import 'extensions/success_colors.dart';

class AppDarkTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppFontStyles.fontFamily,
      // textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: const Color.fromARGB(255, 45, 45, 75),
        primaryContainer: ColorsResourcesDark.primaryContainer,
        onPrimary: ColorsResourcesDark.onPrimary,
        onPrimaryContainer: ColorsResourcesDark.onPrimaryContainer,
        secondary: ColorsResourcesDark.secondary,
        secondaryContainer: ColorsResourcesDark.secondaryContainer,
        onSecondary: ColorsResourcesDark.onSecondary,
        onSecondaryContainer: ColorsResourcesDark.onSecondaryContainer,
        tertiary: ColorsResourcesDark.tertiary,
        tertiaryContainer: ColorsResourcesDark.tertiaryContainer,
        onTertiary: ColorsResourcesDark.onTertiary,
        onTertiaryContainer: ColorsResourcesDark.onTertiaryContainer,
        error: ColorsResourcesDark.error,
        errorContainer: ColorsResourcesDark.errorContainer,
        onError: ColorsResourcesDark.onError,
        //
        surface: ColorsResourcesDark.surface,
        onSurface: ColorsResourcesDark.onSurface,
        surfaceContainer: ColorsResourcesDark.containerColors.surfaceContainer,
        surfaceContainerHigh: ColorsResourcesDark.containerColors.surfaceContainerHigh,
        surfaceContainerHighest: ColorsResourcesDark.containerColors.surfaceContainerHighest,
        surfaceContainerLowest: ColorsResourcesDark.containerColors.surfaceContainerLowest,
        surfaceContainerLow: ColorsResourcesDark.containerColors.surfaceContainerLow,
        onSurfaceVariant: ColorsResourcesDark.onSurfaceVariant,
        //
        outline: ColorsResourcesDark.outline,
        outlineVariant: ColorsResourcesDark.outlineVariant,
        //
        shadow: Colors.transparent,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SuccessColors(
          success: ColorsResourcesDark.success,
          onSuccess: ColorsResourcesDark.onSuccess,
          successContainer: ColorsResourcesDark.successContainer,
        ),
        ExtraColors(
          blue: ColorsResourcesDark.blue,
          green: ColorsResourcesDark.green,
          yellow: ColorsResourcesDark.yellow,
          orange: ColorsResourcesDark.orange,
          pink: ColorsResourcesDark.pink,
          red: ColorsResourcesDark.error,
        ),
        OptionCardColors(
          borders: ColorsResourcesDark.outlineVariant,
          bordersCorrect: ColorsResourcesDark.success.withAlpha(100),
          bordersIncorrect: ColorsResourcesDark.error.withAlpha(100),
          bordersNotes: ColorsResourcesDark.yellow,
          background: ColorsResourcesDark.containerColors.surfaceContainerLowest,
          backgroundCorrect: ColorsResourcesDark.successContainer.withAlpha(50),
          backgroundIncorrect: ColorsResourcesDark.onError.withAlpha(50),
          backgroundNotes: ColorsResourcesDark.yellow.withAlpha(50),
          text: ColorsResourcesDark.onSurface,
          textCorrect: ColorsResourcesDark.success,
          textIncorrect: ColorsResourcesDark.error,
          textNotes: ColorsResourcesDark.yellow,
        ),
      ],
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStylesResources.cardMediumTitle.copyWith(
          color: ColorsResourcesDark.onSurface,
        ),
        subtitleTextStyle: TextStylesResources.cardMediumSubtitle.copyWith(
          color: ColorsResourcesDark.onSurfaceVariant,
        ),
      ),

      ///
      popupMenuTheme: PopupMenuThemeData(
        elevation: 0.5,
        labelTextStyle: WidgetStatePropertyAll(
          TextStylesResources.cardSmallSubtitle.copyWith(color: ColorsResourcesDark.onSurface),
        ),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.buttonBorderRadius,
          side: BorderSide(color: ColorsResourcesDark.outline, width: 0.5),
        ),
      ),

      ///
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.onPrimary;
          }
          return ColorsResourcesDark.primaryContainer;
        }),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primary;
          }
          return ColorsResourcesDark.primaryContainer;
        }),
      ),

      ///
      chipTheme: ChipThemeData(
        // Unselected text
        labelStyle: TextStylesResources.chipLabelStyle.copyWith(
          color: ColorsResourcesDark.primary,
        ),
        // Selected text
        secondaryLabelStyle: TextStylesResources.chipLabelStyle.copyWith(
          color: ColorsResourcesDark.primaryContainer,
        ),
        checkmarkColor: ColorsResourcesDark.primaryContainer,
        selectedColor: ColorsResourcesDark.primaryContainer,
        color: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primary;
          }
          return ColorsResourcesDark.containerColors.surfaceContainer;
        }),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        side: BorderSide(color: ColorsResourcesDark.outline, width: 0.5),
      ),

      ///
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primaryContainer;
          }
          return ColorsResourcesDark.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primary;
          }
          return ColorsResourcesDark.containerColors.surfaceContainerLowest;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primary;
          }
          return ColorsResourcesDark.outline;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // Add more properties if needed
        padding: Paddings.zero, // As you already set
      ),

      ///

      ///
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesDark.primary,
        foregroundColor: Colors.white,
      ),

      ///
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsResourcesDark.containerColors.surfaceContainerLowest,
        insetPadding: Paddings.dialogInset,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.dialogBorderRadius),
      ),

      ///
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        color: ColorsResourcesDark.containerColors.surfaceContainerLowest,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(
            color: ColorsResourcesDark.outlineVariant,
            width: SizesResources.cardMediumBorderWidth,
          ),
        ),
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            ColorsResourcesDark.containerColors.surfaceContainerLowest,
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
          backgroundColor: ColorsResourcesDark.primaryContainer,
          foregroundColor: ColorsResourcesDark.primary,
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          side: BorderSide(
            color: ColorsResourcesDark.outline,
            width: SizesResources.buttonBorderWidth,
          ),
        ),
      ),

      ///
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: ColorsResourcesDark.primary,
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button.copyWith(color: ColorsResourcesDark.primary),
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
        ),
      ),

      ///
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.primary,
          foregroundColor: ColorsResourcesDark.primaryContainer,
          disabledBackgroundColor: ColorsResourcesDark.primaryContainer.withAlpha(100),
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadiusResource.buttonBorderRadius,
            side: BorderSide(color: ColorsResourcesDark.outline, width: 0.5),
          ),
          textStyle: TextStylesResources.button,
        ),
      ),

      ///
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.containerColors.surfaceContainerLowest,
          foregroundColor: ColorsResourcesDark.onSurface,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
          side: BorderSide(color: ColorsResourcesDark.outlineVariant),
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
          backgroundColor: ColorsResourcesDark.surface,
          // foregroundColor: ColorsResourcesDark.onSurface,
          foregroundColor: Color(0xff55534F),
          shape: RoundedSuperellipseBorder(
            side: BorderSide(
              color: ColorsResourcesDark.outlineVariant,
              width: SizesResources.iconButtonBorderWidth,
            ),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
        ),
      ),

      ///
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsResourcesDark.surface,
        shadowColor: Colors.transparent,
        actionsPadding: Paddings.screenSidesPadding,
        titleTextStyle: TextStylesResources.appBar.copyWith(color: ColorsResourcesDark.onSurface),
        surfaceTintColor: Colors.transparent,
        leadingWidth: SizesResources.iconButtonAppBarHeight + Paddings.screenSidesPadding.right,
        foregroundColor: ColorsResourcesDark.onSurfaceVariant,
        centerTitle: true,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          minimumSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          fixedSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          maximumSize: WidgetStatePropertyAll(const Size(double.infinity, 200)),
          side: WidgetStatePropertyAll(BorderSide(color: ColorsResourcesDark.outline)),
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.fieldBorderRadius),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: ColorsResourcesDark.containerColors.surfaceContainerLow,

          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: BorderSide(
              color: ColorsResourcesDark.outline,
              width: SizesResources.fieldBorderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: BorderSide(
              color: ColorsResourcesDark.outline,
              width: SizesResources.fieldBorderWidth,
            ),
          ),
          contentPadding: Paddings.fieldContentPadding,
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorsResourcesDark.containerColors.surfaceContainerLow,

        labelStyle: TextStylesResources.textField.copyWith(
          color: ColorsResourcesDark.onSurfaceVariant,
        ),
        helperStyle: TextStylesResources.textFieldHelper.copyWith(
          color: ColorsResourcesDark.onSurfaceVariant,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesDark.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesDark.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesDark.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadiusResource.fieldBorderRadius,
        //   borderSide: const BorderSide(color: ColorsResourcesDark.outline,width: 0..20),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: BorderSide(
            color: ColorsResourcesDark.outline,
            width: SizesResources.fieldBorderWidth,
          ),
        ),
        outlineBorder: BorderSide(color: ColorsResourcesDark.outline),
        contentPadding: Paddings.fieldContentPadding,
      ),
    );
  }
}
