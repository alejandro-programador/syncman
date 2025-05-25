import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/zone/zone_write_repository.dart';

class LocalZoneWriteRepository extends ZoneWriteRepository {
  final Future<Database> _database;

  LocalZoneWriteRepository(this._database);

  Future<Database> _getZoneDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Area area) async {
    final zoneDB = await _getZoneDB();
    await zoneDB.insert(
      'areas',
      area.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateArea(Area area) async {
    final zoneDB = await _getZoneDB();
    await zoneDB.update(
      'areas',
      area.toMap(),
      where: 'id = ?',
      whereArgs: [area.id],
    );
  }

  Future<void> deleteArea(String id) async {
    final zoneDB = await _getZoneDB();
    await zoneDB.delete(
      'areas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 