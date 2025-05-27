import 'package:bac_project/core/resources/themes/dark_theme.dart';
import 'package:bac_project/core/resources/themes/light_theme.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  final String appThemeKey;
  final CacheManager cacheManager;
  AppThemeBloc({required this.cacheManager, required this.appThemeKey}) : super(AppThemeState.defaultTheme()) {
    on<ChangeAppThemeEvent>(onChangeAppThemeEvent);
    on<InitializeAppThemeEvent>(onInitializeAppThemeEvent);
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
    //
    final String? value = (await cacheManager().read(appThemeKey)) as String?;
    //
    if (value == AppThemes.lightTheme.name) {
      emit(AppThemeState(themeData: AppLightTheme.theme()));
    }
    if (value == AppThemes.darkTheme.name) {
      emit(AppThemeState(themeData: AppDarkTheme.theme()));
    } else {
      emit(AppThemeState(themeData: AppLightTheme.theme()));
    }
  }
}
