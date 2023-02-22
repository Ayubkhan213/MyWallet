import 'package:get/get.dart';
import 'package:my_wallet/modules/splash/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SplashController>(() => SplashController());
    Get.put<SplashController>(SplashController());
  }
}
