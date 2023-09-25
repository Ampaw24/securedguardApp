import 'package:atusecurityapp/module/locationmodule.dart';
import 'package:atusecurityapp/modules/locationmodule.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const int _version = 1;
  static const String _dbName = "locations.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Location(id INTEGER PRIMARY KEY, locationId TEXT NOT NULL,locationName TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addLocation(Locations location) async {
    final db = await _getDB();
    return await db.insert("Location", location.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateLocation(Locations location) async {
    final db = await _getDB();
    return await db.update("Location", location.toJson(),
        where: 'id = ?',
        whereArgs: [location.locationId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteLocation(Locations location) async {
    final db = await _getDB();
    return await db.delete(
      "Location",
      where: 'id = ?',
      whereArgs: [location.locationId],
    );
  }

  static Future<List<Locations>?> getLocations() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Location');

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Locations.fromJson(maps[index]));
  }
}
