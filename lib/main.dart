// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/binding/all_binding.dart';
import 'package:my_wallet/faces/splash_face.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  //open the box
  var box = await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ALLBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Wallet APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashFace(),
    );
  }
}
