import 'package:bac_project/core/resources/themes/dark_theme.dart';
import 'package:bac_project/core/resources/themes/light_theme.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> with WidgetsBindingObserver {
  final String appThemeKey;
  final CacheManager cacheManager;
  AppThemeBloc({required this.cacheManager, required this.appThemeKey})
    : super(AppThemeState.defaultTheme()) {
    WidgetsBinding.instance.addObserver(this);
    on<ChangeAppThemeEvent>(onChangeAppThemeEvent);
    on<InitializeAppThemeEvent>(onInitializeAppThemeEvent);
    on<SystemBrightnessChangedEvent>(onSystemBrightnessChangedEvent);
  }

  /// Gets the current system brightness
  Brightness _getSystemBrightness() {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  /// Gets theme data based on system brightness
  ThemeData _getThemeFromSystemBrightness() {
    final brightness = _getSystemBrightness();
    return brightness == Brightness.dark ? AppDarkTheme.theme() : AppLightTheme.theme();
  }

  /// Checks if there's a stored theme preference
  Future<bool> _hasStoredThemePreference() async {
    final value = await cacheManager().read(appThemeKey);
    return value != null;
  }

  onChangeAppThemeEvent(ChangeAppThemeEvent event, Emitter<AppThemeState> emit) {
    switch (event.theme) {
      case AppThemes.lightTheme:
        emit(AppThemeState(themeData: AppLightTheme.theme()));
        cacheManager().write(appThemeKey, AppThemes.lightTheme.name);
      case AppThemes.darkTheme:
        emit(AppThemeState(themeData: AppDarkTheme.theme()));
        cacheManager().write(appThemeKey, AppThemes.darkTheme.name);
    }
  }

  onInitializeAppThemeEvent(InitializeAppThemeEvent event, Emitter<AppThemeState> emit) async {
    final String? value = (await cacheManager().read(appThemeKey)) as String?;

    if (value == AppThemes.lightTheme.name) {
      emit(AppThemeState(themeData: AppLightTheme.theme()));
    } else if (value == AppThemes.darkTheme.name) {
      emit(AppThemeState(themeData: AppDarkTheme.theme()));
    } else {
      // No stored preference - use system theme
      emit(AppThemeState(themeData: _getThemeFromSystemBrightness()));
    }
  }

  onSystemBrightnessChangedEvent(SystemBrightnessChangedEvent event, Emitter<AppThemeState> emit) {
    // Update theme to match current system brightness
    emit(AppThemeState(themeData: _getThemeFromSystemBrightness()));
  }

  @override
  void didChangePlatformBrightness() {
    // Only update theme if no stored preference exists
    _hasStoredThemePreference().then((hasStored) {
      if (!hasStored) {
        // No stored preference - follow system theme
        add(const SystemBrightnessChangedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
