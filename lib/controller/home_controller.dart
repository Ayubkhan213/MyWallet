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

  //List for table Column
  List<String> tableColumn = [
    'Title',
    'Expance Type',
    'Expance',
    'Date',
    'Source',
  ];

  // Total Expance
  var totalExpance = 0.obs;

  // Food Expance
  var foodExpance = 0.obs;
  // electricty Expance
  var electrictyExpance = 0.obs;
  // rent Expance
  var rentExpance = 0.obs;
  // traveling Expance
  var travelingExpance = 0.obs;
  // jim Expance
  var jimExpance = 0.obs;
  // frind Expance
  var frindExpance = 0.obs;

  //List for expanceData
  var expanceData = [].obs;

  // ExpanceType Length
  var expanceTypeLength = 0.obs;

  //List For ExpanceType name
  var expanceTypeName = [].obs;

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
    expanceTypeLength.value == expanceTypeData.length;
    await HomeDBHelper.instance.getExpanceData(_myBox.get('id'));
    for (var i = 0; i < expanceTypeData.length; i++) {
      expanceTypeName.add(expanceTypeData[i]['expance_type']);
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
        var electrictyData = await HomeDBHelper.instance
            .getExpanceCategoriesData(
                usersId: _myBox.get('id'), expanceTypeId: 2);
        for (var i = 0; i < electrictyData.length; i++) {
          if (DateTime.now().year.toString() ==
              electrictyData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                electrictyData[i]['date'].toString().substring(3, 5)) {
              electrictyExpance.value += electrictyData[i]['expance'] as int;
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
              travelingExpance.value += travelingData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 4) {
        var jimData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 5);
        for (var i = 0; i < jimData.length; i++) {
          if (DateTime.now().year.toString() ==
              jimData[i]['date'].toString().substring(6)) {
            if (DateTime.now().month.toString() ==
                jimData[i]['date'].toString().substring(3, 5)) {
              jimExpance.value += jimData[i]['expance'] as int;
            }
          }
        }
      }
      if (i == 5) {
        var frindData = await HomeDBHelper.instance.getExpanceCategoriesData(
            usersId: _myBox.get('id'), expanceTypeId: 6);
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
    }
    expanceTypeValue.add(foodExpance);
    expanceTypeValue.add(electrictyExpance);
    expanceTypeValue.add(rentExpance);
    expanceTypeValue.add(travelingExpance);
    expanceTypeValue.add(jimExpance);
    expanceTypeValue.add(frindExpance);
  }

  // Function for get ExpanceTypeName
  getExpanceTypeName({required int? id}) async {
    var responce = await HomeDBHelper.instance.getExpanceTypeName(id: id);
    return responce[0]['expance_type'];
  }

  // function for clear and re-load
  clearReload() {
    totalExpance.value = 0;
    expanceData.clear();
    getExpanceData();
    expanceTypeValue.clear();
    expanceTypeName.clear();
    foodExpance.value = 0;
    rentExpance.value = 0;
    electrictyExpance.value = 0;
    frindExpance.value = 0;
    jimExpance.value = 0;
    getAllCategoriesData();
  }

  @override
  void onInit() async {
    super.onInit();
    await getExpanceData();
    await getAllCategoriesData();
  }
}
