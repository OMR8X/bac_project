import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
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
      ],
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesDark.surfaceContainerHigh,
        foregroundColor: ColorsResourcesDark.primary,
      ),
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
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.appBarAction,
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(ColorsResourcesDark.surfaceContainerHigh),
          alignment: Alignment.topCenter,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadiusResource.fieldBorderRadius),
          ),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(AppTextStyles.menuButton)),
      ),

      ///
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          //
          backgroundColor: ColorsResourcesDark.primary,
          foregroundColor: Colors.white,
          //
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          //
          textStyle: AppTextStyles.button,
        ),
      ),

      ///
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(iconSize: 15, minimumSize: const Size(20, 20)),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        fillColor: ColorsResourcesDark.surfaceContainerHigh,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        // TODO: add padding
        contentPadding: EdgeInsets.zero,
        // contentPadding: PaddingResources.padding_3_1,
      ),
    );
  }
}
