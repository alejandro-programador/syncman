import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/zone/zone_read_repository.dart';

class LocalZoneReadRepository extends ZoneReadRepository {
  final Future<Database> _database;

  LocalZoneReadRepository(this._database);

  Future<Database> _getZoneDB() async {
    return await _database;
  }

  @override
  Future<List<Area>> query({String? updatedAt, int? page}) async {
    final zoneDB = await _getZoneDB();
    final List<Map<String, dynamic>> maps = await zoneDB.query('areas');
    return List.generate(maps.length, (i) {
      return Area.fromMap(maps[i]);
    });
  }

  @override
  Future<Area?> getById(String id) async {
    final zoneDB = await _getZoneDB();
    final List<Map<String, dynamic>> maps = await zoneDB.query(
      'areas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Area.fromMap(maps.first);
  }

  @override
  Future<Area?> getByCodigo(String codigo) async {
    final zoneDB = await _getZoneDB();
    final List<Map<String, dynamic>> maps = await zoneDB.query(
      'areas',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (maps.isEmpty) return null;
    return Area.fromMap(maps.first);
  }
} 