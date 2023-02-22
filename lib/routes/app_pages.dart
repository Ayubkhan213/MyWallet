// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:my_wallet/modules/add%20expance/binding/add_expance_binding.dart';
import 'package:my_wallet/modules/add%20expance/pages/add_expance_page.dart';
import 'package:my_wallet/modules/all%20expances/binding/all_expance_binding.dart';
import 'package:my_wallet/modules/all%20expances/screen/all_expances.dart';
import 'package:my_wallet/modules/auth/binding/auth_binding.dart';
import 'package:my_wallet/modules/auth/pages/login_page.dart';
import 'package:my_wallet/modules/auth/pages/signup_page.dart';
import 'package:my_wallet/modules/home/binding/home_binding.dart';
import 'package:my_wallet/modules/home/pages/home_page.dart';
import 'package:my_wallet/modules/splash/binding/splash_binding.dart';
import 'package:my_wallet/modules/splash/page/splash_page.dart';
import 'package:my_wallet/modules/update_expance/binding/update_binding.dart';
import 'package:my_wallet/modules/update_expance/pages/update_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPANCES,
      page: () => const AddExpancePage(),
      binding: AddExpanceBinding(),
    ),
    GetPage(
      name: _Paths.ALL_EXPANCES,
      page: () => const AllExpancesPage(),
      binding: AllExpanceBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_EXPANCES,
      page: () => const UpdateExpancePage(),
      binding: UpdateBinding(),
    ),
  ];
}
