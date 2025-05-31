import 'package:bac_project/core/services/router/app_transations.dart';
import 'package:bac_project/presentation/home/views/home_view.dart';
import 'package:bac_project/presentation/result/views/result_view.dart';
import 'package:bac_project/presentation/root/views/auth_views_manager.dart';
import 'package:bac_project/presentation/settings/views/setting_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/root/views/app_loader_view.dart';
import '../../../presentation/root/views/pages_holder.dart';
import '../../../presentation/testing/views/debugs_view.dart';
import 'app_arguments.dart';
import 'app_routes.dart';

class AppRouter {
  ///
  /// keys for the root navigator
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorResult = GlobalKey<NavigatorState>();
  static final _rootNavigatorSetting = GlobalKey<NavigatorState>();

  /// developing
  ///
  static final router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: AppRoutes.loader.path,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// debugging route
      GoRoute(
        name: AppRoutes.root.name,
        path: AppRoutes.root.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
              },
              child: const DebugsView(),
            ),
      ),

      // auth views manager route
      GoRoute(
        name: AppRoutes.authViewsManager.name,
        path: AppRoutes.authViewsManager.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
              },
              child: const AuthViewsManager(),
            ),
      ),
      // loader route
      GoRoute(
        name: AppRoutes.loader.name,
        path: AppRoutes.loader.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
              },
              child: AppLoaderView(key: state.pageKey),
            ),
      ),

      /// add page view route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PagesHolderView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              ///
              /// Home route
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                pageBuilder:
                    (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      transitionDuration: AppTransitions.transitionDuration,
                      reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                      },
                      child: HomeView(key: state.pageKey),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorResult,
            routes: [
              ///
              /// Result route
              GoRoute(
                name: AppRoutes.result.name,
                path: AppRoutes.result.path,
                pageBuilder:
                    (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      transitionDuration: AppTransitions.transitionDuration,
                      reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                      },
                      child: ResultView(key: state.pageKey),
                    ),
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _rootNavigatorSetting,
            routes: [
              ///
              /// Setting route
              GoRoute(
                name: AppRoutes.setting.name,
                path: AppRoutes.setting.path,
                pageBuilder:
                    (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      transitionDuration: AppTransitions.transitionDuration,
                      reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                      },
                      child: SettingView(key: state.pageKey),
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
