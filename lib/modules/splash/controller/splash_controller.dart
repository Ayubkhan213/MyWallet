import 'dart:async';

import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/routes/app_pages.dart';

class SplashController extends GetxController {
  // Hive Box
  final _myBox = Hive.box('user');

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      _myBox.get('id') != null
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.LOGIN);

      timer.cancel();
    });
  }
}
