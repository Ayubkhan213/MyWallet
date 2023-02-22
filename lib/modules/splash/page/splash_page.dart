// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_wallet/modules/splash/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF2980b9),
      body: Center(
        child: SizedBox(
          width: width - 50,
          child: Lottie.asset('assets/json/wallet.json'),
        ),
      ),
    );
  }
}
