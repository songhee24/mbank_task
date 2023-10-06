import 'dart:async';
import 'dart:io';

import 'package:mbank_task/manufacturers/models/mfr_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Manufacturer ("
          "Mfr_ID INTEGER PRIMARY KEY,"
          "Country TEXT,"
          "Mfr_Name TEXT"
          ")");

      await db.execute("CREATE TABLE VehicleTypes ("
          "VehicleType_ID INTEGER PRIMARY KEY,"
          "GVWRFrom TEXT,"
          "GVWRTo TEXT,"
          "IsPrimary INTEGER,"
          "Name TEXT,"
          "Mfr_ID INTEGER,"
          "FOREIGN KEY (Mfr_ID) REFERENCES Manufacturer(Mfr_ID)"
          ")");
    });
  }

  newMfrs(List<MfrModel> newMfrs) async {
    final db = await database;
    for (var newMfr in newMfrs) {
      final existingMfr = await db.query(
        'Manufacturer',
        where: 'Mfr_ID = ?',
        whereArgs: [newMfr.mfrId],
      );

      if (existingMfr.isEmpty) {
        var manufacturerId = await db.insert('Manufacturer', {
          'Mfr_ID': newMfr.mfrId,
          'Country': newMfr.country,
          'Mfr_Name': newMfr.mfrName,
        });

        if (newMfr.vehicleTypes != null) {
          for (var vehicleType in newMfr.vehicleTypes!) {
            await db.insert('VehicleTypes', {
              'GVWRFrom': vehicleType.gVWRFrom,
              'GVWRTo': vehicleType.gVWRTo,
              'IsPrimary': vehicleType.isPrimary,
              'Name': vehicleType.name,
              'Mfr_ID': manufacturerId, // Use inserted id
            });
          }
        }
      } else {
        // Manufacturer already exists, you can handle this case as needed
        // For example, you can update the existing record or skip it
      }
    }
  }
}
