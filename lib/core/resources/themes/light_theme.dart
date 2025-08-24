import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/themes/extensions/extra_colors.dart';
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
      // textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
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
        surfaceContainer: ColorsResourcesLight.surfaceContainer,
        surfaceContainerHigh: ColorsResourcesLight.surfaceContainerHigh,
        surfaceContainerHighest: ColorsResourcesLight.surfaceContainerHighest,
        onSurfaceVariant: ColorsResourcesLight.onSurfaceVariant,
        //
        outline: ColorsResourcesLight.outline,
        outlineVariant: ColorsResourcesLight.outlineVariant,
        //
        shadow: ColorsResourcesLight.shadow,
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
        ExtraColors(
          blue: ColorsResourcesLight.blue,
          green: ColorsResourcesLight.green,
          yellow: ColorsResourcesLight.yellow,
          orange: ColorsResourcesLight.orange,
          pink: ColorsResourcesLight.pink,
          red: ColorsResourcesLight.error,
        ),
      ],
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppTextStyles.cardMediumTitle.copyWith(
          color: ColorsResourcesLight.onSurface,
        ),
        subtitleTextStyle: AppTextStyles.cardMediumSubtitle.copyWith(
          color: ColorsResourcesLight.onSurfaceVariant,
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
        labelStyle: AppTextStyles.chipLabelStyle.copyWith(color: ColorsResourcesLight.primary),
        // Selected text
        secondaryLabelStyle: AppTextStyles.chipLabelStyle.copyWith(
          color: ColorsResourcesLight.primaryContainer,
        ),
        checkmarkColor: ColorsResourcesLight.primaryContainer,
        selectedColor: ColorsResourcesLight.primaryContainer,
        color: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.primaryContainer;
        }),
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
          return ColorsResourcesLight.surfaceContainer;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsResourcesLight.primary;
          }
          return ColorsResourcesLight.outline;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // Add more properties if needed
        // padding: EdgeInsets.zero, // As you already set
      ),

      ///
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyles.appBar.copyWith(color: ColorsResourcesLight.onSurface),
        surfaceTintColor: Colors.transparent,
        foregroundColor: ColorsResourcesLight.onSurface,
        iconTheme: IconThemeData(
          fill: 1,
          color: ColorsResourcesLight.onSurfaceVariant,
          opticalSize: 1,
          size: 25,
        ),
      ),

      ///

      ///
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsResourcesLight.primary,
        foregroundColor: Colors.white,
      ),

      ///
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsResourcesLight.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusResource.dialogBorderRadius),
      ),

      ///
      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: ColorsResourcesLight.shadow.withAlpha(10),
        color: ColorsResourcesLight.surfaceContainer,

        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(color: ColorsResourcesLight.outline),
        ),
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(ColorsResourcesLight.surfaceContainer),
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
          backgroundColor: ColorsResourcesLight.primaryContainer,
          foregroundColor: ColorsResourcesLight.primary,
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
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
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
        ),
      ),

      ///
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.surfaceContainer,
          foregroundColor: ColorsResourcesLight.onSurface,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
          side: BorderSide(color: ColorsResourcesLight.outline),
        ),
      ),

      ///
      // iconButtonTheme: IconButtonThemeData(
      //   style: IconButton.styleFrom(
      //     iconSize: 10,
      //     alignment: Alignment.center,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadiusResource.buttonBorderRadius,
      //       side: BorderSide(color: ColorsResourcesLight.outline),
      //     ),
      //   ),
      // ),
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
          fillColor: ColorsResourcesLight.surfaceContainer,

          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: ColorsResourcesLight.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: ColorsResourcesLight.outline),
          ),
          contentPadding: PaddingResources.fieldContentPadding,
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorsResourcesLight.surfaceContainer,

        labelStyle: AppTextStyles.textField.copyWith(color: ColorsResourcesLight.onSurfaceVariant),
        helperStyle: AppTextStyles.textFieldHelper.copyWith(
          color: ColorsResourcesLight.onSurfaceVariant,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadiusResource.fieldBorderRadius,
        //   borderSide: const BorderSide(color: ColorsResourcesLight.outline),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline),
        ),
        outlineBorder: BorderSide(color: ColorsResourcesLight.outline),
        contentPadding: PaddingResources.fieldContentPadding,
      ),
    );
  }
}
