import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/auth/login_face.dart';
import 'package:my_wallet/faces/home_face.dart';

class SplashController extends GetxController {
  // Hive Box
  final _myBox = Hive.box('user');

  final getStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    if (_myBox.get('id') != null) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offAll(const HomeFace());
        timer.cancel();
      });
    } else {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offAll(const LoginFace());
        timer.cancel();
      });
    }
  }
}
