import 'package:get/get.dart';
import 'package:my_wallet/controller/all_expance_transcation_controller.dart';
import 'package:my_wallet/controller/expances_controller.dart';
import 'package:my_wallet/controller/home_controller.dart';
import 'package:my_wallet/controller/login_controller.dart';
import 'package:my_wallet/controller/signup_controller.dart';
import 'package:my_wallet/controller/splash_controller.dart';
import 'package:my_wallet/controller/update_expance_controller.dart';

class ALLBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<LoginController>(LoginController());
    Get.put<SignupController>(SignupController());
    Get.put<HomeController>(HomeController());
    Get.put<ExpancesController>(ExpancesController());
    Get.put<AllExpanceTranscation>(AllExpanceTranscation());
    Get.put<UpdateExpancesController>(UpdateExpancesController());
  }
}
