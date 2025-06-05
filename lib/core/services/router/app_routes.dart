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

  testing(name: 'testing', path: '/testing');

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
