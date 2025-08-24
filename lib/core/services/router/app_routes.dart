/// Represents the app routes and their paths.
enum AppRoutes {
  root(name: 'root', path: '/root'),
  loader(name: 'loader', path: '/loader'),
  home(name: 'home', path: '/home'),
  lessons(name: 'lessons', path: '/lessons'),
  authViewsManager(name: 'auth-views-manager', path: '/auth-views-manager'),
  designing(name: 'designing', path: '/designing'),
  auth(name: 'auth', path: '/auth'),
  setting(name: 'setting', path: '/setting'),
  result(name: 'result', path: '/result'),
  testModeSettings(name: 'test-mode-settings', path: '/test-mode-settings'),
  setTestProperties(name: 'set-test-properties', path: '/set-test-properties'),
  pickLessons(name: 'pick-lessons', path: '/pick-lessons'),
  quizzing(name: 'quizzing', path: '/quizzing'),
  search(name: 'search', path: '/search'),
  notificationDetails(name: 'notification-details', path: '/notification-details'),
  updateUserData(name: 'update-user-data', path: '/update-user-data');

  const AppRoutes({required this.name, required this.path});

  /// Represents the route name
  ///
  /// Example: `AppRoutes.home.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.home.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
