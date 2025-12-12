import 'package:bac_project/core/services/router/app_transations.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/presentation/auth/view/update_user_data_view.dart';
import 'package:bac_project/presentation/auth/view/update_password_view.dart';
import 'package:bac_project/presentation/settings/views/about_us_view.dart';
import 'package:bac_project/presentation/settings/views/help_center_view.dart';
import 'package:bac_project/presentation/settings/views/contact_us_view.dart';
import 'package:bac_project/presentation/home/blocs/lessons_bloc.dart';
import 'package:bac_project/presentation/home/views/home_view.dart';
import 'package:bac_project/presentation/home/views/lessons_view.dart';
import 'package:bac_project/presentation/root/blocs/loader/app_loader_bloc.dart';
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
import '../../../presentation/auth/view/auth_view.dart';
import '../../../presentation/notifications/views/notifications_topics_view.dart';
import '../../../presentation/notifications/views/notifications_view.dart';
import '../../../presentation/result/views/explore_results_view.dart';
import '../../../presentation/root/blocs/navigation/navigation_cubit.dart';
import '../../../presentation/root/views/app_loader_view.dart';
import '../../../presentation/root/views/pages_holder.dart';
import '../../../presentation/testing/views/debugs_view.dart';

import '../../../presentation/tests/views/test_mode_settings_view.dart';
import 'routes.dart';

class AppRouter {
  ///
  /// keys for the root navigator
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorResult = GlobalKey<NavigatorState>();
  static final _rootNavigatorSetting = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  /// developing
  ///
  static final router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: Routes.home.path,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: sl<NavigationCubit>(),
    redirect: sl<NavigationCubit>().redirect,
    routes: [
      /// debugging route
      GoRoute(
        name: Routes.root.name,
        path: Routes.root.path,
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
        name: Routes.authentication.name,
        path: Routes.authentication.path,
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
              child: const AuthenticationView(),
            ),
      ),
      // update user data route
      GoRoute(
        name: Routes.updateUserData.name,
        path: Routes.updateUserData.path,
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
      // update password route
      GoRoute(
        name: Routes.updatePassword.name,
        path: Routes.updatePassword.path,
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
              child: const UpdatePasswordView(),
            ),
      ),
      // about us route
      GoRoute(
        name: Routes.aboutUs.name,
        path: Routes.aboutUs.path,
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
              child: const AboutUsView(),
            ),
      ),
      // help center route
      GoRoute(
        name: Routes.helpCenter.name,
        path: Routes.helpCenter.path,
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
              child: const HelpCenterView(),
            ),
      ),
      // contact us route
      GoRoute(
        name: Routes.contactUs.name,
        path: Routes.contactUs.path,
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
              child: const ContactUsView(),
            ),
      ),
      // designing route
      GoRoute(
        name: Routes.designing.name,
        path: Routes.designing.path,
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
        name: Routes.loader.name,
        path: Routes.loader.path,
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
              child: const AppLoaderView(),
            ),
      ),
      // notifications route
      GoRoute(
        name: Routes.notifications.name,
        path: Routes.notifications.path,
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
        name: Routes.notificationsTopics.name,
        path: Routes.notificationsTopics.path,
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
        name: Routes.lessons.name,
        path: Routes.lessons.path,
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
                  arguments: LessonsViewArguments.fromState(state),
                ),
              ),
            ),
      ),
      // test mode settings route
      GoRoute(
        name: Routes.testModeSettings.name,
        path: Routes.testModeSettings.path,
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
        name: Routes.quizzing.name,
        path: Routes.quizzing.path,
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
        name: Routes.setTestProperties.name,
        path: Routes.setTestProperties.path,
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
        name: Routes.pickLessons.name,
        path: Routes.pickLessons.path,
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
                  arguments: PickLessonsArguments.fromState(state),
                ),
              ),
            ),
      ),

      // Search route
      GoRoute(
        name: Routes.search.name,
        path: Routes.search.path,
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
                  arguments: SearchViewArguments.fromState(state),
                ),
              ),
            ),
      ),

      // Submit Result route
      GoRoute(
        name: Routes.exploreResult.name,
        path: Routes.exploreResult.path,
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
                  arguments: ExploreResultViewArguments.fromState(state),
                ),
              ),
            ),
      ),

      // Explore Answers Evaluations route
      GoRoute(
        name: Routes.exploreAnswersEvaluations.name,
        path: Routes.exploreAnswersEvaluations.path,
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
        name: Routes.fetchCustomQuestions.name,
        path: Routes.fetchCustomQuestions.path,
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
                arguments: FetchCustomQuestionsArguments.fromState(state),
              ),
            ),
      ),

      // Motivational Quote route
      GoRoute(
        name: Routes.motivationalQuote.name,
        path: Routes.motivationalQuote.path,
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

      /// root page view route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PagesHolderView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              /// Home route
              GoRoute(
                name: Routes.home.name,
                path: Routes.home.path,
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

                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorResult,
            routes: [
              /// Result route
              GoRoute(
                name: Routes.exploreResults.name,
                path: Routes.exploreResults.path,
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
              /// Setting route
              GoRoute(
                name: Routes.setting.name,
                path: Routes.setting.path,
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
