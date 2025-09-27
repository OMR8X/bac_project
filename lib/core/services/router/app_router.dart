import 'package:bac_project/core/services/router/app_transations.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/presentation/auth/view/update_user_data_view.dart';
import 'package:bac_project/presentation/home/blocs/lessons_bloc.dart';
import 'package:bac_project/presentation/home/views/home_view.dart';
import 'package:bac_project/presentation/home/views/lessons_view.dart';
import 'package:bac_project/presentation/search/bloc/bloc/search_bloc.dart';
import 'package:bac_project/presentation/settings/views/setting_view.dart';
import 'package:bac_project/presentation/testing/views/designing_view.dart';
import 'package:bac_project/presentation/result/bloc/submit_results/explore_result_bloc.dart';
import 'package:bac_project/presentation/result/views/explore_result_view.dart';
import 'package:bac_project/presentation/result/views/explore_answers_evaluations_view.dart';
import 'package:bac_project/presentation/tests/blocs/test_mode_settings/test_mode_settings_bloc.dart';
import 'package:bac_project/presentation/tests/views/pick_lessons_view.dart';
import 'package:bac_project/presentation/quizzing/views/quizzing_view.dart';
import 'package:bac_project/presentation/tests/views/fetch_custom_questions_view.dart';
import 'package:bac_project/presentation/tests/widgets/set_test_properties.dart';
import 'package:bac_project/presentation/search/views/search_view.dart';
import 'package:bac_project/presentation/home/views/motivational_quote_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/presentation/tests/blocs/pick_lessons/pick_lessons_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/auth/view/auth_views_manager.dart';
import '../../../presentation/notifications/views/notifications_topics_view.dart';
import '../../../presentation/notifications/views/notifications_view.dart';
import '../../../presentation/result/views/explore_results_view.dart';
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
      // notifications route
      GoRoute(
        name: AppRoutes.notifications.name,
        path: AppRoutes.notifications.path,
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
              child: NotificationsView(key: state.pageKey),
            ),
      ),
      // notifications topics route
      GoRoute(
        name: AppRoutes.notificationsTopics.name,
        path: AppRoutes.notificationsTopics.path,
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
              child: NotificationsTopicsView(key: state.pageKey),
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
              child: BlocProvider(
                create: (context) {
                  final arguments = state.extra as TestModeSettingsArguments?;
                  return sl<TestModeSettingsBloc>()..add(
                    TestModeSettingsLoadEvent(
                      unitIds: arguments?.unitIds,
                      lessonIds: arguments?.lessonIds,
                    ),
                  );
                },
                child: TestModeSettingsView(
                  key: state.pageKey,
                  arguments: state.extra as TestModeSettingsArguments?,
                ),
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
              child: QuizzingView(key: state.pageKey, arguments: state.extra as QuizzingArguments?),
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
                create: (context) => sl<SearchBloc>(),
                child: SearchView(
                  key: state.pageKey,
                  arguments: state.extra as SearchViewArguments,
                ),
              ),
            ),
      ),

      // Submit Result route
      GoRoute(
        name: AppRoutes.exploreResult.name,
        path: AppRoutes.exploreResult.path,
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
                create: (context) => sl<ExploreResultBloc>(),
                child: ExploreResultView(
                  key: state.pageKey,
                  arguments: state.extra as ExploreResultViewArguments,
                ),
              ),
            ),
      ),

      // Explore Answers Evaluations route
      GoRoute(
        name: AppRoutes.exploreAnswersEvaluations.name,
        path: AppRoutes.exploreAnswersEvaluations.path,
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
              child: ExploreAnswersEvaluationsView(
                key: state.pageKey,
                arguments: state.extra as ExploreAnswersEvaluationsViewArguments,
              ),
            ),
      ),

      // Fetch Custom Questions route
      GoRoute(
        name: AppRoutes.fetchCustomQuestions.name,
        path: AppRoutes.fetchCustomQuestions.path,
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
              child: FetchCustomQuestionsView(
                key: state.pageKey,
                arguments: state.extra as FetchCustomQuestionsArguments,
              ),
            ),
      ),

      // Motivational Quote route
      GoRoute(
        name: AppRoutes.motivationalQuote.name,
        path: AppRoutes.motivationalQuote.path,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: AppTransitions.transitionDuration * 4,
              reverseTransitionDuration: AppTransitions.reverseTransitionDuration * 6,

              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return AppTransitions.circularExpansionTransition(
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
              child: MotivationalQuoteView(
                key: state.pageKey,
                quote: (state.extra as MotivationalQuoteArguments).quote,
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
                name: AppRoutes.exploreResults.name,
                path: AppRoutes.exploreResults.path,
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
                      child: ExploreResultsView(key: state.pageKey),
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
    ],
  );
}
