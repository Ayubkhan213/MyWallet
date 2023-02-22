import 'package:get/get.dart';

import 'package:my_wallet/modules/auth/controller/login_controller.dart';
import 'package:my_wallet/modules/auth/controller/signup_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
