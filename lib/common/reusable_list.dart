import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/model/expance_model.dart';
import 'package:my_wallet/model/expance_type_model.dart';
import 'package:my_wallet/model/signup_model.dart';

//List for Signupdata
RxList<SignupModel> signupData = <SignupModel>[].obs;

//List for expanceData
RxList<ExpanceModel> monthlyExpanceData = <ExpanceModel>[].obs;

//List for Single Expance Data
RxList<ExpanceModel> singleExpanceData = <ExpanceModel>[].obs;
//List for total Expances Data
RxList<ExpanceModel> totalExpancesData = <ExpanceModel>[].obs;

//List For ExpanceType value
RxList<int> expanceTypeValue = <int>[].obs;

//function formating date
String? dateFormating({required String givenDate}) {
  String dateString = givenDate;
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime date = formatter.parse(dateString);
  var formated = DateFormat.MMM().format(date);
  return formated;
}

//List for CategoriesName
var expanceTypeName = [
  'Food',
  'Utiles',
  'Rent',
  'Transport',
  'Health',
  'Home',
  'Frind',
  'Other',
];

//List for CategoriesName and id
List<ExpanceType> expanceTypeData = [
  ExpanceType(id: 1, expance_type: 'Food'),
  ExpanceType(id: 2, expance_type: 'Utiles'),
  ExpanceType(id: 3, expance_type: 'Rent'),
  ExpanceType(id: 4, expance_type: 'Transport'),
  ExpanceType(id: 5, expance_type: 'Health'),
  ExpanceType(id: 6, expance_type: 'Home'),
  ExpanceType(id: 7, expance_type: 'Frind'),
  ExpanceType(id: 8, expance_type: 'Other'),
];
