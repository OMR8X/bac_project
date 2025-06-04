import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:flutter/material.dart';

import '../styles/font_styles_manager.dart';
import '../styles/sizes_resources.dart';
import 'extensions/success_colors.dart';

class AppLightTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppFontStyles.fontFamily,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorsResourcesLight.primary,
        primaryContainer: ColorsResourcesLight.primaryContainer,
        onPrimary: ColorsResourcesLight.onPrimary,
        secondary: ColorsResourcesLight.primary,
        onSecondary: ColorsResourcesLight.primary,
        error: ColorsResourcesLight.error,
        errorContainer: ColorsResourcesLight.errorContainer,
        onError: ColorsResourcesLight.onError,
        //
        surface: ColorsResourcesLight.surface,
        onSurface: ColorsResourcesLight.onSurface,
        onSurfaceVariant: ColorsResourcesLight.onSurfaceVariant,
        //
        outline: ColorsResourcesLight.outline,
        outlineVariant: ColorsResourcesLight.outlineVariant,
        //
        shadow: ColorsResourcesLight.lightShadow,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SurfaceContainerColors(
          surfaceContainer: ColorsResourcesLight.surfaceContainer,
          surfaceContainerHigh: ColorsResourcesLight.surfaceContainerHigh,
        ),
        SuccessColors(
          success: ColorsResourcesLight.success,
          onSuccess: ColorsResourcesLight.onSuccess,
        ),
      ],

      ///
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyles.appBarAction.copyWith(
          color: ColorsResourcesLight.onSurface,
        ),
        surfaceTintColor: Colors.transparent,
        foregroundColor: ColorsResourcesLight.onSurface,
        iconTheme: IconThemeData(
          fill: 1,
          color: ColorsResourcesLight.onSurfaceVariant,
          opticalSize: 1,
        ),
      ),

      ///
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesLight.primary,
        foregroundColor: Colors.white,
      ),

      ///
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsResourcesLight.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusResource.dialogBorderRadius,
        ),
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
          contentPadding: PaddingResources.padding_3_1,
        ),
      ),

      ///

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(
            ColorsResourcesLight.surfaceContainer,
          ),
          alignment: Alignment.topCenter,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusResource.fieldBorderRadius,
            ),
          ),
        ),
      ),

      ///
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledBackgroundColor: ColorsResourcesLight.onSurfaceVariant,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      ///
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          iconSize: 15,
          minimumSize: const Size(20, 20),
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        fillColor: ColorsResourcesLight.surfaceContainerHigh,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding: PaddingResources.padding_3_1,
      ),
    );
  }
}
