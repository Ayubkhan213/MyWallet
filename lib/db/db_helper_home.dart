// ignore_for_file: unused_field, prefer_const_declarations, invalid_return_type_for_catch_error, body_might_complete_normally_nullable, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:io';
import 'package:my_wallet/model/expance_model.dart';
import 'package:my_wallet/model/expance_type_model.dart';
import 'package:my_wallet/model/signup_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HomeDBHelper {
  static final _dbName = 'wallet.db';
  static final _nameColumn = 'name';
  static final _emailColumn = 'email';
  static final _authtableName = 'auth_table';
  static final _passwordColumn = 'password';
  static final _tableName = 'expance_table';
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

  HomeDBHelper._privatConstructor();
  static final instance = HomeDBHelper._privatConstructor();

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
        'CREATE TABLE $_tableName($_idColumn INTEGER PRIMARY KEY,$_userIdColumn INTEGER,$_titleColumn VARCHAR,$_expanceTypeColumn int,$_expanceColumn INTEGER,$_dateColumn TEXT,$_sourceColumn TEXT,$_filterDate INTEGER)');
  }

  Future<SignUp?> insertData(SignUp signUp) async {
    var _db = await database;
    _db!.insert(_authtableName, signUp.toMap());
    return signUp;
  }

  Future<List<Map<String, Object?>>> getData() async {
    var _db = await database;
    var _result = _db!.query(_authtableName);
    return _result;
  }

  Future<ExpanceType?> insertExpanceType(ExpanceType expanceType) async {
    var _db = await database;
    _db!.insert(_secondtableName, expanceType.toMap());
    return expanceType;
  }

  Future<Expance?> insertExpance(Expance expance) async {
    var _db = await database;
    _db!.insert(_tableName, expance.toMap());
  }

  // Future<List<Map<String, Object?>>> getExpancesTypeData() async {
  //   var _db = await database;
  //   var result = _db!.query(_secondtableName);
  //   return result;
  // }

  Future<List<Map<String, Object?>>> getExpanceData(int id) async {
    var _db = await database;
    var result = _db!.query(_tableName, where: 'user_id=?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getUserId(String userEmail) async {
    var _db = await database;
    var data = _db!.query(_authtableName,
        where: '$_emailColumn = ?', whereArgs: [userEmail]);
    return data;
  }

  Future<List<Map<String, dynamic>>> getExpanceCategoriesData(
      {required int? usersId, required int? expanceTypeId}) async {
    var _db = await database;
    var data = _db!.rawQuery(
        'SELECT * FROM $_tableName WHERE user_id= $usersId AND expance_type = $expanceTypeId');
    return data;
  }

  Future<List<Map<String, dynamic>>> getExpanceTypeName(
      {required int? id}) async {
    var _db = await database;
    var data = _db!.query(_secondtableName, where: 'id=?', whereArgs: [id]);
    return data;
  }

  Future<List<Map<String, dynamic>>> getSelectedCategoriesData(
      {required int? id, required int? userId}) async {
    var _db = await database;
    var data = _db!.rawQuery(
        'SELECT * FROM $_tableName WHERE user_id =$userId AND expance_type = $id');
    return data;
  }

  Future<List<Map<String, dynamic>>> getselectDateDate(
      {required int startDate, required int endDate}) async {
    var _db = await database;
    var result = _db!.rawQuery(
        'SELECT * FROM $_tableName WHERE $_filterDate >= $startDate AND $_filterDate<=$endDate');
    return result;
  }

  deleteRowOfTable({required int id}) async {
    var _db = await database;
    _db!.delete(_tableName, where: 'id=?', whereArgs: [id]);
  }

  updateExpanceData(Expance expance) async {
    var _db = await database;
    var result = _db!.update(_tableName, expance.toMap(),
        where: 'id=?', whereArgs: [expance.id]);
    return result;
  }

  getSingleRecord(int id) async {
    var _db = await database;
    return _db!.rawQuery('SELECT * FROM $_tableName WHERE id = $id');
  }
}
