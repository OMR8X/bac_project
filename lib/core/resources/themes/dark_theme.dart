import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
import 'package:bac_project/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:flutter/material.dart';
import '../styles/border_radius_resources.dart';
import '../styles/padding_resources.dart';
import 'extensions/success_colors.dart';

class AppDarkTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      fontFamily: AppFontStyles.fontFamily,
      brightness: Brightness.dark,
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
        surface: ColorsResourcesDark.surface,
        onSurface: ColorsResourcesDark.onSurface,
        onSurfaceVariant: ColorsResourcesDark.onSurfaceVariant,
        //
        outline: ColorsResourcesDark.outline,
        outlineVariant: ColorsResourcesDark.outlineVariant,
        //
        shadow: ColorsResourcesDark.lightShadow,
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
        ),
      ],
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppTextStyles.cardMediumTitle.copyWith(
          color: ColorsResourcesDark.onSurface,
        ),
        subtitleTextStyle: AppTextStyles.cardMediumSubtitle.copyWith(
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
        labelStyle: AppTextStyles.chipLabelStyle.copyWith(color: ColorsResourcesDark.primary),
        // Selected text
        secondaryLabelStyle: AppTextStyles.chipLabelStyle.copyWith(
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
        // padding: EdgeInsets.zero, // As you already set
      ),

      ///
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyles.appBar.copyWith(color: ColorsResourcesDark.onSurface),

        surfaceTintColor: Colors.transparent,
        foregroundColor: ColorsResourcesDark.onSurface,
        iconTheme: IconThemeData(
          fill: 1,
          color: ColorsResourcesDark.onSurfaceVariant,
          opticalSize: 1,
          size: 25,
        ),
      ),

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
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          // TODO: add padding
          contentPadding: EdgeInsets.zero,
          // contentPadding: PaddingResources.padding_3_1,
        ),
      ),

      ///
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: ColorsResourcesDark.lightShadow.withAlpha(20),
        color: ColorsResourcesDark.surfaceContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(color: ColorsResourcesDark.outline),
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

      ///
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.primary.withAlpha(100),
          foregroundColor: ColorsResourcesDark.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
          // side: BorderSide(color: ColorsResourcesDark.outline),
        ),
      ),

      ///
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.primary,
          disabledBackgroundColor: ColorsResourcesDark.primaryContainer.withAlpha(100),
          foregroundColor: ColorsResourcesDark.primaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
        ),
      ),

      ///
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesDark.surfaceContainer,
          foregroundColor: ColorsResourcesDark.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
          side: BorderSide(color: ColorsResourcesDark.outline),
        ),
      ),

      ///
      // iconButtonTheme: IconButtonThemeData(
      //   style: IconButton.styleFrom(iconSize: 10, minimumSize: const Size(20, 20)),
      // ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorsResourcesDark.surfaceContainer,
        hintStyle: AppTextStyles.textField.copyWith(color: ColorsResourcesDark.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outlineVariant, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outlineVariant, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outlineVariant, width: 0.5),
        ),
        // shape: RoundedSuperellipseBorder(
        //   borderRadius: BorderRadiusResource.cardBorderRadius,
        //   side: BorderSide(color: ColorsResourcesDark.outlineVariant,width: 0.5),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesDark.outlineVariant, width: 0.5),
        ),
        contentPadding: PaddingResources.fieldContentPadding,
      ),
    );
  }
}
