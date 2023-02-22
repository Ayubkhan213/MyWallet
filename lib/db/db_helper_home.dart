// ignore_for_file: unused_field, prefer_const_declarations, invalid_return_type_for_catch_error, body_might_complete_normally_nullable, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:io';
import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/model/expance_model.dart';

import 'package:my_wallet/model/signup_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _dbName = 'wallet.db';
  static final _nameColumn = 'name';
  static final _emailColumn = 'email';
  static final _authtableName = 'auth_table';
  static final _passwordColumn = 'password';
  static final _expanceTable = 'expance_table';
  static final _secondtableName = 'expance_type_table';
  static final _version = 1;
  static final _idColumn = 'id';
  static final _userIdColumn = 'user_id';
  static final _titleColumn = 'title';
  static final _expanceTypeColumn = 'expance_type';
  static final _expanceColumn = 'expance';
  static final _dateColumn = 'date';
  static final _sourceColumn = 'source';
  static final _filterDate = 'filter_date';

  DBHelper._privatConstructor();
  static final instance = DBHelper._privatConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String _path = join(directory.path, _dbName);
    return await openDatabase(_path, version: _version, onCreate: _onCreate)
        .then((value) {
      return value;
    }).catchError((e) => print('ERROR IN OPENDATABASE:$e'));
  }

  _onCreate(Database? _db, int version) async {
    await _db!.execute(
        'CREATE TABLE $_authtableName($_idColumn INTEGER PRIMARY KEY,  $_nameColumn TEXT, $_emailColumn TEXT, $_passwordColumn TEXT)');
    await _db.execute(
        'CREATE TABLE $_secondtableName($_idColumn INTEGER PRIMARY KEY,$_expanceTypeColumn VARCHAR)');
    await _db.execute(
        'CREATE TABLE $_expanceTable($_idColumn INTEGER PRIMARY KEY,$_userIdColumn INTEGER,$_titleColumn VARCHAR,$_expanceTypeColumn int,$_expanceColumn INTEGER,$_dateColumn TEXT,$_sourceColumn TEXT,$_filterDate INTEGER)');
  }

//Signup New Person
  Future<SignupModel?> signupNewPerson(SignupModel signUp) async {
    var _db = await database;
    _db!.insert(_authtableName, signUp.toMap());
    return signUp;
  }

//GetSignup Data
  Future<void> getSignupData() async {
    var _db = await database;
    var result = await _db!.rawQuery('SELECT * FROM $_authtableName');
    var data = result.map((e) => SignupModel.fromMap(e)).toList();
    signupData.value = data;
  }

//Insert Expance
  Future<ExpanceModel?> insertExpance(ExpanceModel expanceModel) async {
    var _db = await database;
    _db!.insert(_expanceTable, expanceModel.toMap());
  }

//Get Total expance data
  Future<void> getTotalExpanceData(int id) async {
    var _db = await database;
    var result =
        await _db!.query(_expanceTable, where: 'user_id=?', whereArgs: [id]);
    var data = result.map((e) => ExpanceModel.fromMap(e)).toList();
    totalExpancesData.value = data;
    monthlyExpanceData.clear();
    for (var i = 0; i < totalExpancesData.length; i++) {
      if (DateTime.now().year.toString() ==
          totalExpancesData[i].date.toString().substring(6)) {
        if (DateTime.now().toString().substring(5, 7) ==
            totalExpancesData[i].date.toString().substring(3, 5)) {
          monthlyExpanceData.add(totalExpancesData[i]);
        }
      }
    }
  }

//Single User data
  Future<List<Map<String, dynamic>>> getUserData(String userEmail) async {
    var _db = await database;
    var data = _db!.query(_authtableName,
        where: '$_emailColumn = ?', whereArgs: [userEmail]);
    return data;
  }

//function for selected category data
  Future<void> getSelectedCategoriesTotalExpance(
      {required int? expanceTypeId, required int? userId}) async {
    var _db = await database;
    var result = await _db!.rawQuery(
        'SELECT * FROM $_expanceTable WHERE user_id =$userId AND expance_type = $expanceTypeId');
    var data = result.map((e) => ExpanceModel.fromMap(e)).toList();
    totalExpancesData.value = data;
  }

//function for fetching selected date data
  Future<void> getselectDateDate(
      {required int startDate, required int endDate}) async {
    var _db = await database;
    var result = await _db!.rawQuery(
        'SELECT * FROM $_expanceTable WHERE $_filterDate >= $startDate AND $_filterDate<=$endDate');
    var data = result.map((e) => ExpanceModel.fromMap(e)).toList();
    totalExpancesData.value = data;
  }

//function for deleting data
  deleteRowOfTable({required int id}) async {
    var _db = await database;
    _db!.delete(_expanceTable, where: 'id=?', whereArgs: [id]);
  }

//function for update data
  updateExpanceData(ExpanceModel expanceModel) async {
    var _db = await database;
    var result = _db!.update(_expanceTable, expanceModel.toMap(),
        where: 'id=?', whereArgs: [expanceModel.id]);
    return result;
  }

//Get Category Expance Of Current Month
  Future<int> getCategoryDataOfCurrentMonth({
    required int userId,
    required int expenceTypeId,
  }) async {
    var _db = await database;
    var result = await _db!.rawQuery(
        'SELECT * FROM $_expanceTable WHERE $_userIdColumn = $userId AND $_expanceTypeColumn = $expenceTypeId');
    var totalExpance = 0;
    for (var i = 0; i < result.length; i++) {
      if (DateTime.now().year.toString() ==
          result[i]['date'].toString().substring(6)) {
        if (DateTime.now().toString().substring(5, 7) ==
            result[i]['date'].toString().substring(3, 5)) {
          totalExpance += result[i]['expance'] as int;
        }
      }
    }

    return totalExpance;
  }
}
