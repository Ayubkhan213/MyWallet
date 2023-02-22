// ignore_for_file: unnecessary_null_comparison, invalid_return_type_for_catch_error, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/model/expance_model.dart';

class UpdateExpanceController extends GetxController {
  var dataForUpdate = Get.arguments;

  // hive Box
  final _mybox = Hive.box('user');

  // variable for date in integer form
  var filterDate = 0.obs;

  // Form Key
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // decloration controller
  late TextEditingController titleController,
      expanceTypeController,
      expanceController,
      dateController,
      sourceController;

  // valiable for controller with no value
  var title = '';
  var expanceType = 0;
  var expance = 0;
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
    titleController.text = dataForUpdate['title'];
    expanceController.text = dataForUpdate['expance'].toString();
    dateController.text = dataForUpdate['date'];
    expanceType = dataForUpdate['expance_type_id'];
    sourceController.text = dataForUpdate['source'];
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
    //here i convert the date to number
    var date = DateFormat('dd-MM-yyyy').parse(dateController.text);
    var modifyDate = DateFormat('ddMMyyyy').format(date);
    var integerDate = int.parse(modifyDate);
    filterDate.value = integerDate;
    updateExpanceData();
  }

  updateExpanceData() async {
    await DBHelper.instance
        .updateExpanceData(
      ExpanceModel(
        id: dataForUpdate['id'],
        user_id: _mybox.get('id'),
        title: title,
        expance_type: expanceType,
        expance: expance,
        date: date,
        source: source,
        filter_date: filterDate.value,
      ),
    )
        .then((value) async {
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
      monthlyExpanceData.clear();
      totalExpancesData.clear();
      await DBHelper.instance.getTotalExpanceData(_mybox.get('id'));

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
