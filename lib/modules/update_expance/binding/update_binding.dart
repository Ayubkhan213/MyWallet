import 'package:get/get.dart';
import 'package:my_wallet/modules/update_expance/controller/update_expance_controller.dart';

class UpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateExpanceController>(() => UpdateExpanceController());
  }
}
