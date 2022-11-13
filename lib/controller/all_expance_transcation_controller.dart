import 'package:get/state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/db/db_helper_home.dart';

class AllExpanceTranscation extends GetxController {
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

  //List for expanceData
  var expanceData = [].obs;

  //list for expanceType data
  // var expanceTypeData = [].obs;

  // open box
  final _myBox = Hive.box('user');

  //function for selected categories data
  getSelectedCategoriesData({required int? id}) async {
    List<Map<String, Object?>> data = await HomeDBHelper.instance
        .getSelectedCategoriesData(userId: _myBox.get('id'), id: id);
    expanceData.clear();
    categoriesExpance.value = 0;
    for (var i = 0; i < data.length; i++) {
      expanceData.add(data[i]);
      categoriesExpance.value += data[i]['expance'] as int;
    }
  }

  // Function for getExpanceData
  getExpanceData() async {
    List<Map<String, Object?>> data =
        await HomeDBHelper.instance.getExpanceData(_myBox.get('id'));
    for (var i = 0; i < data.length; i++) {
      expanceData.add(data[i]);
      categoriesExpance.value += data[i]['expance'] as int;
    }
  }

  // Function for get ExpanceTypeName
  getExpanceTypeName({required int? id}) async {
    var responce = await HomeDBHelper.instance.getExpanceTypeName(id: id);
    return responce[0]['expance_type'];
  }

  @override
  void onInit() {
    super.onInit();
    getExpanceData();
    // getExpanceTypeData();
  }
}
