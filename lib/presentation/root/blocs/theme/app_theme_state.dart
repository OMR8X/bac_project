part of 'app_theme_bloc.dart';

final class AppThemeState extends Equatable {
  //
  final ThemeData themeData;
  //
  const AppThemeState({required this.themeData});
  //
  factory AppThemeState.defaultTheme() {
    return AppThemeState(themeData: AppLightTheme.theme());
  }

  @override
  List<Object> get props => [themeData];
}
