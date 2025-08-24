import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/colors_resources.dart';
import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/presentation/root/blocs/theme/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bac_project/l10n/generated/app_localizations.dart';

class AppRoot extends StatelessWidget {
  const AppRoot._internal();

  static const AppRoot _instance = AppRoot._internal();

  factory AppRoot() => _instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppThemeBloc>()..add(const InitializeAppThemeEvent()),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'مدير الملفات',
            theme: state.themeData,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
