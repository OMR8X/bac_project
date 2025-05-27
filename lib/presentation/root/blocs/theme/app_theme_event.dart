part of 'app_theme_bloc.dart';

enum AppThemes {
  lightTheme,
  darkTheme,
}

sealed class AppThemeEvent extends Equatable {
  const AppThemeEvent();
  @override
  List<Object> get props => [];
}

final class InitializeAppThemeEvent extends AppThemeEvent {
  //
  const InitializeAppThemeEvent();
}

final class ChangeAppThemeEvent extends AppThemeEvent {
  //
  final AppThemes theme;
  //
  const ChangeAppThemeEvent(this.theme);

  @override
  List<Object> get props => [theme];
}
