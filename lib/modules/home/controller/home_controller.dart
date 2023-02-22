// ignore_for_file: unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, avoid_print

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/routes/app_pages.dart';

class HomeController extends GetxController {
// open box
  final _myBox = Hive.box('user');

  //bool for expance value
  var expancevalue = true.obs;

  // Total Expance
  RxInt totalExpance = 0.obs;

/*here i get expance of all type and seperatly add that
to list of type in expanceTypeValue*/
  getAllExpanceTypeValue() async {
    for (var i = 0; i < expanceTypeName.length; i++) {
      var result = await DBHelper.instance.getCategoryDataOfCurrentMonth(
          userId: _myBox.get('id'), expenceTypeId: i);
      expanceTypeValue.add(result);
    }
  }

  //logout function
  logout() {
    _myBox.deleteAll(['id', 'name', 'email', 'password']);
    Get.offAllNamed(Routes.LOGIN);
  }

  // Function for Filter TotalExpanceOfCurrentMonth
  getTotalExpanceOfCurrentMonth() {
    for (var i = 0; i < totalExpancesData.length; i++) {
      if (DateTime.now().year.toString() ==
          totalExpancesData[i].date.toString().substring(6)) {
        if (DateTime.now().toString().substring(5, 7) ==
            totalExpancesData[i].date.toString().substring(3, 5)) {
          totalExpance.value += totalExpancesData[i].expance!;
        }
      }
    }
  }

  // function for clear and re-load
  clearReload() async {
    totalExpance.value = 0;
    monthlyExpanceData.clear();
    await DBHelper.instance.getTotalExpanceData(_myBox.get('id'));
    await getTotalExpanceOfCurrentMonth();
    expanceTypeValue.clear();
    getAllExpanceTypeValue();
  }

  @override
  void onInit() async {
    super.onInit();

    clearReload();
  }
}
