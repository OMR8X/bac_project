import 'package:bac_project/core/services/router/app_transations.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/presentation/auth/view/update_user_data_view.dart';
import 'package:bac_project/presentation/home/blocs/lessons_bloc.dart';
import 'package:bac_project/presentation/home/views/home_view.dart';
import 'package:bac_project/presentation/home/views/lessons_view.dart';
import 'package:bac_project/presentation/search/bloc/bloc/search_bloc.dart';
import 'package:bac_project/presentation/settings/views/setting_view.dart';
import 'package:bac_project/presentation/testing/views/designing_view.dart';
import 'package:bac_project/presentation/tests/views/pick_lessons_view.dart';
import 'package:bac_project/presentation/tests/views/quizzing_view.dart';
import 'package:bac_project/presentation/tests/widget/set_test_properties.dart';
import 'package:bac_project/presentation/search/views/search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/presentation/tests/blocs/pick_lessons_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/auth/view/auth_views_manager.dart';
import '../../../presentation/result/views/results_view.dart';
import '../../../presentation/root/views/app_loader_view.dart';
import '../../../presentation/root/views/pages_holder.dart';
import '../../../presentation/testing/views/debugs_view.dart';

import '../../../presentation/tests/views/test_mode_settings_view.dart';
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
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
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
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: const AuthViewsManager(),
            ),
      ),
      GoRoute(
        name: AppRoutes.updateUserData.name,
        path: AppRoutes.updateUserData.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: const UpdateUserDataView(),
            ),
      ),
      // designing route
      GoRoute(
        name: AppRoutes.designing.name,
        path: AppRoutes.designing.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: const DesigningView(),
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
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: AppLoaderView(key: state.pageKey),
            ),
      ),
      // lessons route
      GoRoute(
        name: AppRoutes.lessons.name,
        path: AppRoutes.lessons.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: BlocProvider(
                create: (context) => sl<LessonsBloc>(),
                child: LessonsView(
                  key: state.pageKey,
                  arguments: state.extra as LessonsViewArguments?,
                ),
              ),
            ),
      ),
      // test mode settings route
      GoRoute(
        name: AppRoutes.testModeSettings.name,
        path: AppRoutes.testModeSettings.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: TestModeSettingsView(
                key: state.pageKey,
                arguments: state.extra as TestModeSettingsArguments?,
              ),
            ),
      ),
      // testing route
      GoRoute(
        name: AppRoutes.quizzing.name,
        path: AppRoutes.quizzing.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: QuizzingView(key: state.pageKey, arguments: state.extra as TestingArguments?),
            ),
      ),
      // set test properties route
      GoRoute(
        name: AppRoutes.setTestProperties.name,
        path: AppRoutes.setTestProperties.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: SetTestProperties(key: state.pageKey),
            ),
      ),
      // pick lessons route
      GoRoute(
        name: AppRoutes.pickLessons.name,
        path: AppRoutes.pickLessons.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: BlocProvider<PickLessonsBloc>(
                create: (context) => sl<PickLessonsBloc>(),
                child: PickLessonsView(
                  key: state.pageKey,
                  arguments: state.extra as PickLessonsArguments,
                ),
              ),
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
                        return AppTransitions.commonTransition(
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        );
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
                        return AppTransitions.commonTransition(
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        );
                      },
                      child: ResultsView(key: state.pageKey),
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
                        return AppTransitions.commonTransition(
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        );
                      },
                      child: SettingView(key: state.pageKey),
                    ),
              ),
            ],
          ),
        ],
      ),

      // Search route
      GoRoute(
        name: AppRoutes.search.name,
        path: AppRoutes.search.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.commonTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: BlocProvider(
                create:
                    (context) =>
                        sl<SearchBloc>()
                          ..add(SearchLessons(unitId: (state.extra as SearchViewArguments).unitId)),
                child: SearchView(
                  key: state.pageKey,
                  arguments: state.extra as SearchViewArguments,
                ),
              ),
            ),
      ),
    ],
  );
}
