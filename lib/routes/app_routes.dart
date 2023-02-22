// ignore_for_file: unused_element, unused_field, constant_identifier_names
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const ADD_EXPANCES = _Paths.ADD_EXPANCES;
  static const ALL_EXPENCES = _Paths.ALL_EXPANCES;
  static const UPDATE_EXPENCES = _Paths.UPDATE_EXPANCES;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const ALL_EXPANCES = '/all_expances';
  static const ADD_EXPANCES = '/add_expances';
  static const UPDATE_EXPANCES = '/update_expances';
}
