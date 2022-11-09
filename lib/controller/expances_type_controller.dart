// ignore_for_file: unnecessary_null_comparison, avoid_print, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/controller/expances_controller.dart';
import 'package:my_wallet/db/db_helper_home.dart';

import 'package:my_wallet/model/expance_type_model.dart';

class ExpancesTypeController extends GetxController {
//Expance controller
  var data = Get.find<ExpancesController>();

  // Form Key
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // List for Expances_type tabledata
  var expanceTypeData = [].obs;

  // decloration controller
  late TextEditingController expanceTypeController;

  // valiable for controller with no value

  var expanceType = '';

  // variable for loading
  final loading = false.obs;

  //init function with decleration controller
  @override
  void onInit() {
    super.onInit();
    expanceTypeController = TextEditingController();
    getExpancesData();
  }

  // variable for complete mark
  var expanceTypeComplete = ''.obs;
  // ExpandedType validation
  String? expancesTypeValidation(String value) {
    if (value == null || value.isEmpty) {
      expanceTypeComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      expanceTypeComplete.value = 'true';
      return null;
    }
  }

  //check Signup
  void checkValidation() async {
    final isValid = key.currentState!.validate();

    if (!isValid) {
      return;
    }

    key.currentState!.save();
    print(expanceType);
    await insertExpandedTypeData();
  }

  // Insert Data
  insertExpandedTypeData() async {
    await HomeDBHelper.instance
        .insertExpanceType(ExpanceType(expance_type: expanceType))
        .then((value) {
      print('Successfully add Data');
      expanceTypeController.text = '';
      expanceTypeComplete.value = '';
      data.expanceTypeData.clear();
      data.getExpanceTypeData();
    }).catchError((e) => print('Error:$e'));
  }

  // Get ExpancesType Data
  Future<List<Map<String, Object?>>> getExpancesData() async {
    var data = await HomeDBHelper.instance.getExpancesTypeData();
    for (var i = 0; i < data.length; i++) {}

    return data;
  }

  // close function
  @override
  void onClose() {
    super.onClose();
    expanceTypeController.dispose();
  }
}
