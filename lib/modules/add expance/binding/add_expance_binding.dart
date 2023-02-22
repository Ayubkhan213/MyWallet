import 'package:get/get.dart';
import 'package:my_wallet/modules/add%20expance/controller/add_expance_controller.dart';

class AddExpanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpanceController>(() => AddExpanceController());
  }
}
