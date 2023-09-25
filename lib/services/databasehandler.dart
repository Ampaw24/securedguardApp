import 'dart:io'; 
import 'package:atusecurityapp/modules/guardassignmodule.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  static int get _version => 1;

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the wrms table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'LocationDB.db');
    print(path);
    return await openDatabase(path, version: _version, onOpen: (db) {},
        onCreate: (Database db, int version) async {
     
       
      
      await db.execute('CREATE TABLE LocationInfo('
          'guardName TEXT,'
          'locationName TEXT,'
          ')');
      
      //===2nd table
    });
  } 
   
//Funtion to insert location to local Db
  Future<void> insertLocation(LocationInfo location) async {
    final db = await database; 
    await db!.insert(
      'LocationInfo',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


//===========end of the code in add local

 
  Future<int> deleteAllLogin() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM LoginInfo');
    print("delete all data in  LoginInfo Table ");
    return res;
  }
 
  Future<List<LocationInfo>> getUserLocation() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM LocationInfo");
    print(res);
    List<LocationInfo> list =
        res.isNotEmpty ? res.map((c) => LocationInfo.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteSUserLocation() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM LocationInfo');
    print("delete all data in  LocationInfo Table ");
    return res;
  }


  
}