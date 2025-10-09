/// Represents the app routes and their paths.
enum Routes {
  root(name: 'root', path: '/root'),
  loader(name: 'loader', path: '/loader'),
  home(name: 'home', path: '/home'),
  lessons(name: 'lessons', path: '/lessons'),
  updateAvailable(name: 'update-app', path: '/update-available'),
  authentication(name: 'auth-views-manager', path: '/auth-views-manager'),
  designing(name: 'designing', path: '/designing'),
  auth(name: 'auth', path: '/auth'),
  setting(name: 'setting', path: '/setting'),
  exploreResults(name: 'explore-results', path: '/explore-results'),
  exploreResult(name: 'explore-result', path: '/explore-result'),
  exploreAnswersEvaluations(
    name: 'explore-answers-evaluations',
    path: '/explore-answers-evaluations',
  ),
  testModeSettings(name: 'test-mode-settings', path: '/test-mode-settings'),
  setTestProperties(name: 'set-test-properties', path: '/set-test-properties'),
  pickLessons(name: 'pick-lessons', path: '/pick-lessons'),
  quizzing(name: 'quizzing', path: '/quizzing'),
  search(name: 'search', path: '/search'),
  notifications(name: 'notifications', path: '/notifications'),
  notificationsTopics(name: 'notifications-topics', path: '/notifications-topics'),
  updateUserData(name: 'update-user-data', path: '/update-user-data'),
  fetchCustomQuestions(name: 'fetch-custom-questions', path: '/fetch-custom-questions'),
  motivationalQuote(name: 'motivational-quote', path: '/motivational-quote');

  const Routes({required this.name, required this.path});

  /// Represents the route name
  ///
  /// Example: `Routes.home.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `Routes.home.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
