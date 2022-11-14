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

  //bool for expance value
  var expancevalue = true.obs;

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

  //List for expanceData
  var expanceData = [].obs;

  //List For ExpanceType value
  var expanceTypeValue = [].obs;

  //List for CategoriesName
  var expanceTypeData = [
    'Food',
    'Utiles',
    'Rent',
    'Transport',
    'Health',
    'Home',
    'Frind',
    'Other',
  ];

  getALlExpanceTypeValue() async {
    for (var i = 0; i < expanceTypeData.length; i++) {
      var result = await HomeDBHelper.instance.getCategoryDataOfCurrentMonth(
          userId: _myBox.get('id'), expenceTypeId: i);
      expanceTypeValue.add(result);
    }
  }

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

  // function for clear and re-load
  clearReload() {
    totalExpance.value = 0;
    expanceData.clear();
    getExpanceData();
    expanceTypeValue.clear();
    getALlExpanceTypeValue();
  }

  @override
  void onInit() async {
    super.onInit();
    await getExpanceData();
    await getALlExpanceTypeValue();
  }
}
