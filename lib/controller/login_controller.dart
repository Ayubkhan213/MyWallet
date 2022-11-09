// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/controller/home_controller.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/faces/home_face.dart';

class LoginController extends GetxController {
//  home controller
  // var home = Get.find<HomeController>();

  // Refrence box
  final _mybox = Hive.box('user');

  // Form Key
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // decloration controller
  late TextEditingController emailController, passwordController;

  // valiable for controller with no value
  var email = '';
  var password = '';

  //init function with decleration controller
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  // variable for complete mark
  var emailComplete = ''.obs;

// email validation
  String? emailValidation(String value) {
    if (value == null || value.isEmpty) {
      emailComplete.value = 'false';
      return 'Please Fill this Field';
    } else if (!GetUtils.isEmail(value)) {
      emailComplete.value = 'false';
      return 'Please provide Validate Email';
    } else {
      emailComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var passwordComplete = ''.obs;

  // password validation
  String? passwordValidation(String value) {
    if (value == null || value.isEmpty) {
      passwordComplete.value = 'false';
      return 'Please Fill this Field';
    } else if (value.length <= 5) {
      passwordComplete.value = 'false';
      return 'Password Must be 6 letter';
    } else {
      passwordComplete.value = 'true';
      return null;
    }
  }

  // variable for loading
  var loading = false.obs;

  // CheckLogin
  void checkLogin() async {
    final isValid = key.currentState!.validate();

    if (!isValid) {
      return;
    }
    key.currentState!.save();
    loading.value = true;
    bool checkValidation = await emailValidate();
    if (emailValid.value) {
      await putUserData();
      await getExpanceData();
      Get.offAll(const HomeFace());
    } else {
      Get.snackbar(
        'You Enter Wrong Email or Password',
        'Please Enter a Correct Email And Password',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
    emailController.text = '';
    passwordController.text = '';
    passwordComplete.value = '';
    emailComplete.value = '';
    loading.value = false;
  }

  var emailValid = false.obs;
// Validate Email
  Future<bool> emailValidate() async {
    var data = await HomeDBHelper.instance.getData();
    for (var i = 0; i < data.length; i++) {
      if (data[i]['email'] == email && data[i]['password'] == password) {
        emailValid.value = true;
        break;
      }
    }
    return emailValid.value;
  }

  putUserData() async {
    var data = await HomeDBHelper.instance.getUserId(email);
    _mybox.put('id', data[0]['id']);
    _mybox.put('name', data[0]['name']);
    _mybox.put('email', data[0]['email']);
    _mybox.put('password', data[0]['password']);
  }

// Function For get User Id
  Future<int?> getUserId() async {
    return _mybox.get('id');
  }

// Function For get User Name
  Future<String?> getUserName() async {
    return _mybox.get('name');
  }

// Function For get User Email
  Future<String?> getUserEmail() async {
    return _mybox.get('email');
  }

// Function For get User Password
  Future<String?> getUserPassword() async {
    return _mybox.get('password');
  }

  // Function for getExpanceData
  getExpanceData() async {
    var home = Get.find<HomeController>();
    List<Map<String, Object?>> data =
        await HomeDBHelper.instance.getExpanceData(_mybox.get('id'));
    for (var i = 0; i < data.length; i++) {
      home.totalExpance.value += data[i]['expance'] as int;
      print(home.totalExpance);
    }
  }

  // close  function
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
