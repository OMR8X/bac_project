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
      popupMenuTheme: PopupMenuThemeData(
        elevation: 0.5,
        labelTextStyle: WidgetStatePropertyAll(
          AppTextStyles.cardSmallSubtitle.copyWith(color: ColorsResourcesLight.onSurface),
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
        shadowColor: ColorsResourcesLight.shadow.withAlpha(0),
        color: ColorsResourcesLight.surfaceContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusResource.cardBorderRadius,
          side: BorderSide(color: ColorsResourcesLight.outline, width: 0.20),
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

      /// [BUTTONS]
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.primaryContainer,
          foregroundColor: ColorsResourcesLight.primary,
          shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusResource.buttonBorderRadius),
          textStyle: AppTextStyles.button,
          minimumSize: const Size.fromHeight(SizesResources.buttonMediumHeight),
          side: BorderSide(color: ColorsResourcesLight.outline),
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
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          alignment: Alignment.center,
          padding: EdgeInsets.all(12),
          minimumSize: Size(
            SizesResources.iconButtonAppBarHeight,
            SizesResources.iconButtonAppBarHeight,
          ),
          backgroundColor: ColorsResourcesLight.surface,
          foregroundColor: ColorsResourcesLight.onSurface,
          shape: RoundedSuperellipseBorder(
            side: BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
        ),
      ),

      ///
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsResourcesLight.surface,
        shadowColor: Colors.transparent,
        actionsPadding: PaddingResources.screenSidesPadding,
        titleTextStyle: AppTextStyles.appBar.copyWith(color: ColorsResourcesLight.onSurface),
        surfaceTintColor: Colors.transparent,
        leadingWidth:
            SizesResources.iconButtonAppBarHeight + PaddingResources.screenSidesPadding.right,
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
          fillColor: ColorsResourcesLight.surfaceContainer,

          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(color: ColorsResourcesLight.outline, width: 0.75),
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
          borderSide: const BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadiusResource.fieldBorderRadius,
        //   borderSide: const BorderSide(color: ColorsResourcesLight.outline,width: 0..20),
        // ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(color: ColorsResourcesLight.outline, width: 0.5),
        ),
        outlineBorder: BorderSide(color: ColorsResourcesLight.outline),
        contentPadding: PaddingResources.fieldContentPadding,
      ),
    );
  }
}
