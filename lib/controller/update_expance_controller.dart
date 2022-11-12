// ignore_for_file: unnecessary_null_comparison, invalid_return_type_for_catch_error, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:my_wallet/controller/home_controller.dart';
import 'package:my_wallet/controller/login_controller.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/model/expance_model.dart';

class UpdateExpancesController extends GetxController {
  Map<dynamic, dynamic> data = {};
  Map<dynamic, dynamic> initateData = {};
  initializeValue() {
    titleController.text = initateData['title'];
    expanceTypeController.text = initateData['expance_type'].toString();
    expanceController.text = initateData['expance'].toString();
    dateController.text = initateData['date'];
    sourceController.text = initateData['source'];
  }

  // hive Box
  final _mybox = Hive.box('user');

  // Time Formating
  var formateDate = DateTime.now();

  // variable for date in integer form
  var filterDate = 0.obs;

  // Form Key
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  //home Controller
  var home = Get.find<HomeController>();

  // login controller
  var logInController = Get.find<LoginController>();

  // List for Expances_type tabledata
  var expanceTypeData = [].obs;

  // List for Expances tabledata
  var expanceData = [].obs;

  getExpanceData() async {
    List<Map<String, Object?>> data =
        await HomeDBHelper.instance.getExpanceData(_mybox.get('id'));
    for (var i = 0; i < data.length; i++) {
      expanceData.add(data[i]);
    }
  }

  getExpanceTypeData() async {
    List<Map<String, Object?>> data =
        await HomeDBHelper.instance.getExpancesTypeData();

    for (var i = 0; i < data.length; i++) {
      expanceTypeData.add(data[i]);
    }
  }

  // decloration controller
  late TextEditingController titleController,
      expanceTypeController,
      expanceController,
      dateController,
      sourceController;

  // valiable for controller with no value
  var title = '';
  var expanceType = 0;
  var expance;
  var date = '';
  var source = '';

  //init function with decleration controller
  @override
  void onInit() {
    titleController = TextEditingController();
    expanceTypeController = TextEditingController();
    expanceController = TextEditingController();
    dateController = TextEditingController();
    sourceController = TextEditingController();
    getExpanceTypeData();
    getExpanceData();
    super.onInit();
  }

  // variable for complete mark
  var titleComplete = ''.obs;
  // name validation
  String? titleValidation(String value) {
    if (value == null || value.isEmpty) {
      titleComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      titleComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var expanceTypeComplete = ''.obs;
  // name validation
  String? expanceTypeValidation(String? value) {
    if (value == null || value.isEmpty) {
      expanceTypeComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      expanceTypeComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var expanceComplete = ''.obs;
  // expance validation
  String? expanceValidation(String value) {
    if (value == null || value.isEmpty) {
      expanceComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      expanceComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var dateComplete = ''.obs;
  // date validation
  String? dateValidation(String value) {
    if (value == null || value.isEmpty) {
      dateComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      dateComplete.value = 'true';
      return null;
    }
  }

  // variable for complete mark
  var sourceComplete = ''.obs;
  // source validation
  String? sourceValidation(String value) {
    if (value == null || value.isEmpty) {
      sourceComplete.value = 'false';
      return 'Please Fill this Field';
    } else {
      sourceComplete.value = 'true';
      return null;
    }
  }

  // variable for loading
  final loading = false.obs;

  //check Signup
  void checkValidation() async {
    final isValid = key.currentState!.validate();

    if (!isValid) {
      return;
    }

    key.currentState!.save();
    loading.value = true;
    var modifyDate = dateController.text.substring(0, 2) +
        date.toString().substring(3, 5) +
        date.toString().substring(6);
    var integerDate = int.parse(modifyDate);
    filterDate.value = integerDate;
    updateExpanceData();
  }

  updateExpanceData() async {
    expance = int.parse(expance);
    await HomeDBHelper.instance
        .updateExpanceData(
      Expance(
        id: initateData['id'],
        user_id: _mybox.get('id'),
        title: title,
        expance_type: expanceType,
        expance: expance,
        date: date,
        source: source,
        filter_date: filterDate.value,
      ),
    )
        .then((value) {
      print('Successfully update');
      loading.value = false;
      titleController.text = '';
      dateController.text = '';
      expanceController.text = '';
      expanceTypeController.text = '';
      sourceController.text = '';
      titleComplete.value = '';
      expanceComplete.value = '';
      expanceTypeComplete.value = '';
      dateComplete.value = '';
      sourceComplete.value = '';
      expanceData.clear();
      getExpanceData();
      home.clearReload();
      Get.back();
    }).catchError((e) => print('ERROR:$e'));
  }

  // close function
  @override
  void onClose() {
    titleController.dispose();
    expanceTypeController.dispose();
    expanceController.dispose();
    dateController.dispose();
    sourceController.dispose();
    super.onClose();
  }
}
