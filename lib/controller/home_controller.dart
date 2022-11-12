// ignore_for_file: unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, avoid_print

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/auth/login_face.dart';
import 'package:my_wallet/db/db_helper_home.dart';

class HomeController extends GetxController {
  Map<String, dynamic> initateData = {};

//variable for show text field
  var showTextField = false.obs;

// open box
  final _myBox = Hive.box('user');

  // Time Formating
  var formateDate = DateTime.now();

  //List for Month
  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Total Expance
  var totalExpance = 0.obs;
  // Food Expance
  var foodExpance = 0.obs;
  // electricty Expance
  var utilesExpance = 0.obs;
  // rent Expance
  var rentExpance = 0.obs;
  // traveling Expance
  var transportExpance = 0.obs;
  // health Expance
  var healthExpance = 0.obs;
  // home Expance
  var homeExpance = 0.obs;
  // frind Expance
  var frindExpance = 0.obs;
  // other Expance
  var otherExpance = 0.obs;

  //List for expanceData
  var expanceData = [].obs;

  //list for expanceType data
  var expanceTypeData = [].obs;

  //List For ExpanceType value
  var expanceTypeValue = [].obs;

  //logout function
  logout() {
    _myBox.deleteAll(['id', 'name', 'email', 'password']);
    Get.offAll(const LoginFace());
  }

  // Function for getExpanceData
  getExpanceData() async {
    List<Map<String, Object?>> data =
        await HomeDBHelper.instance.getExpanceData(_myBox.get('id'));
    for (var i = 0; i < data.length; i++) {
      if (DateTime.now().year.toString() ==
          data[i]['date'].toString().substring(6)) {
        if (DateTime.now().month.toString() ==
            data[i]['date'].toString().substring(3, 5)) {
          expanceData.add(data[i]);
          totalExpance.value += data[i]['expance'] as int;
        }
      }
    }
  }

  getAllCategoriesData() async {
    var expanceTypeData = await HomeDBHelper.instance.getExpancesTypeData();
    await HomeDBHelper.instance.getExpanceData(_myBox.get('id'));
    for (var i = 0; i < expanceTypeData.length; i++) {
      if (i == 0) {
        var foodData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 1);
        for (var i = 0; i < foodData.length; i++) {
          if (DateTime.now().year.toString() ==
              foodData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                foodData[i]['date'].toString().substring(3, 5)) {
              foodExpance.value += foodData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 1) {
        var utilesData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 2);
        for (var i = 0; i < utilesData.length; i++) {
          if (DateTime.now().year.toString() ==
              utilesData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                utilesData[i]['date'].toString().substring(3, 5)) {
              utilesExpance.value += utilesData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 2) {
        var rentData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 3);
        for (var i = 0; i < rentData.length; i++) {
          if (DateTime.now().year.toString() ==
              rentData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                rentData[i]['date'].toString().substring(3, 5)) {
              rentExpance.value += rentData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 3) {
        var travelingData = await HomeDBHelper.instance
            .getExpanceCategoriesData(
                usersId: _myBox.get('id'), expanceTypeId: 4);
        for (var i = 0; i < travelingData.length; i++) {
          if (DateTime.now().year.toString() ==
              travelingData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                travelingData[i]['date'].toString().substring(3, 5)) {
              transportExpance.value += travelingData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 4) {
        var healthData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 5);
        for (var i = 0; i < healthData.length; i++) {
          if (DateTime.now().year.toString() ==
              healthData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                healthData[i]['date'].toString().substring(3, 5)) {
              healthExpance.value += healthData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 5) {
        var homeData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 6);
        for (var i = 0; i < homeData.length; i++) {
          if (DateTime.now().year.toString() ==
              homeData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                homeData[i]['date'].toString().substring(3, 5)) {
              frindExpance.value += homeData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 6) {
        var frindData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 7);
        for (var i = 0; i < frindData.length; i++) {
          if (DateTime.now().year.toString() ==
              frindData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                frindData[i]['date'].toString().substring(3, 5)) {
              frindExpance.value += frindData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 7) {
        var otherData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 8);
        for (var i = 0; i < otherData.length; i++) {
          if (DateTime.now().year.toString() ==
              otherData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                otherData[i]['date'].toString().substring(3, 5)) {
              otherExpance.value += otherData[i]['expance'] as int;
            }
          }
        }
      }
      expanceTypeValue.add(foodExpance);
      expanceTypeValue.add(utilesExpance);
      expanceTypeValue.add(rentExpance);
      expanceTypeValue.add(transportExpance);
      expanceTypeValue.add(healthExpance);
      expanceTypeValue.add(homeExpance);
      expanceTypeValue.add(frindExpance);
      expanceTypeValue.add(otherExpance);
    }
  }

  getExpanceTypeData() async {
    var responce = await HomeDBHelper.instance.getExpancesTypeData();
    for (var i = 0; i < responce.length; i++) {
      expanceTypeData.add(responce[i]);
    }
  }

  // function for clear and re-load
  clearReload() {
    totalExpance.value = 0;
    expanceData.clear();
    getExpanceData();
    expanceTypeValue.clear();
    foodExpance.value = 0;
    transportExpance.value = 0;
    rentExpance.value = 0;
    utilesExpance.value = 0;
    frindExpance.value = 0;
    healthExpance.value = 0;
    otherExpance.value = 0;
    homeExpance.value = 0;
    getAllCategoriesData();
  }

  @override
  void onInit() async {
    super.onInit();
    await getExpanceData();
    await getAllCategoriesData();
    await getExpanceTypeData();
  }
}
