import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/area/area_read_repository.dart';

class LocalAreaReadRepository extends AreaReadRepository {
  final Future<Database> _database;

  LocalAreaReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<List<Area>> query({
    String? updatedAt,
    int? page,
  }) async {
    final clientDB = await _getClientDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await clientDB.query(
      'areas',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return result.map((map) => Area.fromMap(map)).toList();
  }

  @override
  Future<Area?> getById(String id) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'areas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Area.fromMap(result.first);
    }

    return null;
  }
}
