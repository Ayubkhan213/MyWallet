import 'package:get/get.dart';
import 'package:my_wallet/modules/all%20expances/controller/all_expances_controller.dart';

class AllExpanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AllExpancesController>(AllExpancesController());
  }
}
