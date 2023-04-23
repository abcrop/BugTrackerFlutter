part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const home = _Paths.home;
  static const user = _Paths.user;
  static const bug = _Paths.bug;
  static const activity = _Paths.activity;
  static const project = _Paths.project;
  static const setting = _Paths.setting;
  static const login = _Paths.login;
  static const logout = _Paths.logout;
  static const unknownRoute = _Paths.unknownRoute;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const home = '/home';
  static const user = '/user';
  static const bug = '/bug';
  static const activity = '/activity';
  static const project = '/project';
  static const setting = '/setting';

  static const signup = '/signup';
  static const login = '/login';
  static const logout = '/logout';
  static const unknownRoute = '/unknownRoute';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
