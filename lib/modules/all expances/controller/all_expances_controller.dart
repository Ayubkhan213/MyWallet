import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/db/db_helper_home.dart';

class AllExpancesController extends GetxController {
// variable for categories expance
  var categoriesExpance = 0.obs;

// variable for record
  var record = 'All records'.obs;

  // variable for start selected date
  var selectStartDate = 'start date'.obs;

  // variable for last selected date
  var selectLastDate = 'last date'.obs;

//variable for startdate
  var startDate = 0.obs;
  //variable for lastdate
  var lastDate = 0.obs;

// variable for show box
  var showSearchWay = false.obs;

  // variable for show box
  var showCategories = false.obs;

  // variable for show box
  var showCalender = false.obs;

  // variable for date in integer form
  var integerDate = 0.obs;

  //toggle field
  toggle() {
    showSearchWay.value = !showSearchWay.value;
  }

  // open box
  final _myBox = Hive.box('user');

  //function for selected categories data
  Future<void> getSelectedCategoriesTotalExpance({required int? id}) async {
    totalExpancesData.clear();
    categoriesExpance.value = 0;
    await DBHelper.instance.getSelectedCategoriesTotalExpance(
        userId: _myBox.get('id'), expanceTypeId: id);
    for (var i = 0; i < totalExpancesData.length; i++) {
      categoriesExpance.value += totalExpancesData[i].expance!;
    }
  }

  // Function for getExpanceData
  getTotalExpanceValue() async {
    await DBHelper.instance.getTotalExpanceData(_myBox.get('id'));
    for (var i = 0; i < totalExpancesData.length; i++) {
      categoriesExpance.value += totalExpancesData[i].expance!;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getTotalExpanceValue();
  }
}
