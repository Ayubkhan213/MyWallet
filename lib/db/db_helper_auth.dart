// ignore_for_file: prefer_const_declarations, unused_field, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unused_local_variable, invalid_return_type_for_catch_error, avoid_print

import 'dart:io';
import 'package:my_wallet/model/signup_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthDbHelper {
  static final _dbName = 'wallet.db';
  static final _tableName = 'auth_table';
  static final _version = 1;
  static final _idColumn = 'id';
  static final _nameColumn = 'name';
  static final _emailColumn = 'email';
  static final _passwordColumn = 'password';

  AuthDbHelper._privatConstructor();
  static final instance = AuthDbHelper._privatConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initateDatabase();
      return _database;
    }
  }

  initateDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = join(_directory.path, _dbName);
    var db = await openDatabase(_path, version: _version, onCreate: _onCreate)
        .then((value) {
      return value;
    }).catchError((e) => print('Error in Open Database:$e'));
    return db;
  }

  _onCreate(Database? _db, int version) {
    _db!.execute(
        'CREATE TABLE $_tableName($_idColumn INTEGER PRIMARY KEY,$_nameColumn VARCHAR, $_emailColumn TEXT, $_passwordColumn VARCHAR)');
  }

  Future<SignUp?> insertData(SignUp signUp) async {
    var _db = await database;
    _db!.insert(_tableName, signUp.toMap());
    return signUp;
  }

  Future<List<Map<String, Object?>>> getData() async {
    var _db = await database;
    var _result = _db!.query(_tableName);
    return _result;
  }
}
