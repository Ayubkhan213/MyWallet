// ignore_for_file: unnecessary_null_comparison, invalid_return_type_for_catch_error, avoid_print, unused_local_variable

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/db/db_helper_home.dart';

import 'package:my_wallet/model/signup_model.dart';

class SignupController extends GetxController {
  // Form Key
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // decloration controller
  late TextEditingController nameController,
      passwordController,
      emailController;

  // valiable for controller with no value
  var name = '';
  var email = '';
  var password = '';

  //init function with decleration controller
  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.onInit();
  }

  // variable for complete mark
  var nameComplete = ''.obs;
  // name validation
  String? nameValidation(String value) {
    if (value == null || value.isEmpty) {
      nameComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      nameComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var emailComplete = ''.obs;
  // email validation
  String? emailValidation(String value) {
    if (value == null || value.isEmpty) {
      emailComplete.value = 'false';
      return 'Please Fill this Field';
    } else if (!GetUtils.isEmail(value)) {
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
  final loading = false.obs;

  //check Signup
  void checkSignUp() async {
    final isValid = key.currentState!.validate();
    if (!isValid) {
      return;
    }
    key.currentState!.save();
    loading.value = true;
    bool checkValidation = await emailValidate();
    emailValid.value ? insertData() : null;
    emailValid.value = true;
  }

  var emailValid = true.obs;
// Validate Email
  Future<bool> emailValidate() async {
    var data = await HomeDBHelper.instance.getData();
    for (var i = 0; i < data.length; i++) {
      if (data[i]['email'] == email) {
        Get.snackbar(
          'The Email is Already Present',
          'Please Enter a valid Email',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        emailValid.value = false;
        nameController.text = '';
        emailController.text = '';
        passwordController.text = '';
        nameComplete.value = '';
        passwordComplete.value = '';
        emailComplete.value = '';
        loading.value = false;
        break;
      }
    }

    return emailValid.value;
    // insertData();
  }

  // Insert Data
  insertData() async {
    HomeDBHelper.instance
        .insertData(SignUp(
      name: name,
      email: email,
      password: password,
    ))
        .then((value) {
      print('Successfully add Data of Signup');
      nameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      nameComplete.value = '';
      passwordComplete.value = '';
      emailComplete.value = '';
      loading.value = false;
      Get.back();
    }).catchError((e) => print('Error In Add Data:$e'));
  }

  // close function
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
