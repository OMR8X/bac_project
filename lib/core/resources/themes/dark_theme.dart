import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/surface_container_colors.dart';
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
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: ColorsResourcesDark.primary,
        primaryContainer: ColorsResourcesDark.primaryContainer,
        onPrimary: ColorsResourcesDark.onPrimary,
        secondary: ColorsResourcesDark.primary,
        onSecondary: ColorsResourcesDark.primary,
        error: ColorsResourcesDark.error,
        errorContainer: ColorsResourcesDark.errorContainer,
        onError: ColorsResourcesDark.onError,
        //
        surface: ColorsResourcesDark.surface,
        onSurface: ColorsResourcesDark.onSurface,
        surfaceContainer: ColorsResourcesDark.surfaceContainer,
        surfaceContainerHigh: ColorsResourcesDark.surfaceContainerHigh,
        surfaceContainerHighest: ColorsResourcesDark.surfaceContainerHighest,
        onSurfaceVariant: ColorsResourcesDark.onSurfaceVariant,
        //
        outline: ColorsResourcesDark.outline,
        outlineVariant: ColorsResourcesDark.outlineVariant,
        //
        shadow: Colors.transparent,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SurfaceContainerColors(
          surfaceContainer: ColorsResourcesDark.surfaceContainer,
          surfaceContainerHigh: ColorsResourcesDark.surfaceContainerHigh,
        ),
        SuccessColors(
          success: ColorsResourcesDark.success,
          onSuccess: ColorsResourcesDark.onSuccess,
        ),
        ExtraColors(
          blue: ColorsResourcesDark.blue,
          green: ColorsResourcesDark.green,
          yellow: ColorsResourcesDark.yellow,
          orange: ColorsResourcesDark.orange,
          pink: ColorsResourcesDark.pink,
          red: ColorsResourcesDark.error,
          primaryState: ColorsResourcesDark.primaryState,
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
        labelStyle: TextStylesResources.chipLabelStyle.copyWith(color: ColorsResourcesDark.primary),
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
          return ColorsResourcesDark.primaryContainer;
        }),
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
          return ColorsResourcesDark.surfaceContainer;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesDark.primary;
          }
          return ColorsResourcesDark.outline;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // Add more properties if needed
        // padding: Paddings.zero, // As you already set
      ),

      ///
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsResourcesDark.surface,
        shadowColor: Colors.transparent,
        actionsPadding: Paddings.screenSidesPadding,
        titleTextStyle: TextStylesResources.appBar.copyWith(color: ColorsResourcesDark.onSurface),
        surfaceTintColor: Colors.transparent,
        leadingWidth: 48 + Paddings.screenSidesPadding.right,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsResourcesDark.onSurfaceVariant),
      ),

      ///

      ///
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesDark.primary,
        foregroundColor: Colors.white,
      ),

      ///
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsResourcesDark.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.dialogBorderRadius),
      ),

      ///
      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: Colors.transparent,
        color: ColorsResourcesDark.surfaceContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(color: ColorsResourcesDark.outline, width: 0.20),
        ),
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(ColorsResourcesDark.surfaceContainer),
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
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
        ),
      ),

      ///
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.surfaceContainer,
          foregroundColor: ColorsResourcesDark.onSurface,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: TextStylesResources.button,
          side: BorderSide(color: ColorsResourcesDark.outline),
        ),
      ),

      ///
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          alignment: Alignment.center,
          padding: Paddings.zero,
          backgroundColor: ColorsResourcesDark.surface,
          foregroundColor: ColorsResourcesDark.onSurface,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorsResourcesDark.outline, width: 0.25),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
        ),
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
          fillColor: ColorsResourcesDark.surfaceContainer,

          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: ColorsResourcesDark.outline, width: 0.75),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: ColorsResourcesDark.outline),
          ),
          contentPadding: Paddings.fieldContentPadding,
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorsResourcesDark.surfaceContainer,

        labelStyle: TextStylesResources.textField.copyWith(
          color: ColorsResourcesDark.onSurfaceVariant,
        ),
        helperStyle: TextStylesResources.textFieldHelper.copyWith(
          color: ColorsResourcesDark.onSurfaceVariant,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outline, width: 0.20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outline, width: 0.20),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outline, width: 0.20),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadiusResource.fieldBorderRadius,
        //   borderSide: const BorderSide(color: ColorsResourcesDark.outline,width: 0..20),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outline, width: 0.20),
        ),
        outlineBorder: BorderSide(color: ColorsResourcesDark.outline),
        contentPadding: Paddings.fieldContentPadding,
      ),
    );
  }
}
