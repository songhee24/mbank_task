import 'dart:async';
import 'dart:io';

import 'package:mbank_task/manufacturers/models/mfr_model.dart';
import 'package:mbank_task/manufacturers/models/vehicle_types_model.dart';
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
            final checkIsPrimaryPersisit = vehicleType.isPrimary ?? false;
            await db.insert('VehicleTypes', {
              'GVWRFrom': vehicleType.gVWRFrom,
              'GVWRTo': vehicleType.gVWRTo,
              'IsPrimary': checkIsPrimaryPersisit ? 1 : 0,
              'Name': vehicleType.name,
              'Mfr_ID': manufacturerId, // Use inserted id
            });
          }
        }
      }
    }
  }

  Future<List<MfrModel>> getAllManufacturers(
      {required int limit, required int offset}) async {
    final db = await database;
    final List<Map<String, dynamic>> manufacturerMaps =
        await db.query('Manufacturer', limit: limit, offset: offset);
    List<MfrModel> manufacturers = [];

    for (var index = 0; index < manufacturerMaps.length; index++) {
      final manufacturerId = manufacturerMaps[index]['Mfr_ID'];
      final vehicleTypes = await getVehicleTypesForManufacturer(manufacturerId);

      manufacturers.add(
        MfrModel(
          mfrId: manufacturerMaps[index]['Mfr_ID'],
          country: manufacturerMaps[index]['Country'],
          mfrName: manufacturerMaps[index]['Mfr_Name'],
          vehicleTypes: vehicleTypes,
        ),
      );
    }

    return manufacturers;
  }

  Future<List<VehicleTypeModel>> getVehicleTypesForManufacturer(
      int manufacturerId) async {
    final db = await database;
    final List<Map<String, dynamic>> vehicleTypeMaps = await db.query(
      'VehicleTypes',
      where: 'Mfr_ID = ?',
      whereArgs: [manufacturerId],
    );
    return List.generate(vehicleTypeMaps.length, (index) {
      return VehicleTypeModel(
        gVWRFrom: vehicleTypeMaps[index]['GVWRFrom'],
        gVWRTo: vehicleTypeMaps[index]['GVWRTo'],
        isPrimary: vehicleTypeMaps[index]['IsPrimary'] == 1,
        name: vehicleTypeMaps[index]['Name'],
      );
    });
  }

  Future<MfrModel> getManufacturerById(int manufacturerId) async {
    final db = await database;
    final List<Map<String, dynamic>> manufacturerMaps = await db.query(
      'Manufacturer',
      where: 'Mfr_ID = ?',
      whereArgs: [manufacturerId],
    );

    if (manufacturerMaps.isNotEmpty) {
      final Map<String, dynamic> manufacturerMap = manufacturerMaps.first;
      final List<VehicleTypeModel> vehicleTypes =
          await getVehicleTypesForManufacturer(manufacturerId);

      return MfrModel(
        mfrId: manufacturerMap['Mfr_ID'],
        country: manufacturerMap['Country'],
        mfrName: manufacturerMap['Mfr_Name'],
        vehicleTypes: vehicleTypes,
      );
    } else {
      throw Exception('Manufacturer not found');
    }
  }
}
