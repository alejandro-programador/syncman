import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/repositories/collect/collect_read_repository.dart';

class LocalCollectReadRepository extends CollectReadRepository {
  final Future<Database> _database;

  LocalCollectReadRepository(this._database);

  Future<Database> _getCollectDB() async {
    return await _database;
  }

  @override
  Future<List<Collect>> query({
    String? updatedAt,
    int? page,
  }) async {
    final collectDB = await _getCollectDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await collectDB.query(
      'collects',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Collect.fromMap(map)).toList();
  }

  @override
  Future<Collect?> getById(String id) async {
    final collectDB = await _getCollectDB();

    final result = await collectDB.query(
      'collects',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Collect.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Collect?> getByCodigo(String codigo) async {
    final collectDB = await _getCollectDB();

    final result = await collectDB.query(
      'collects',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Collect.fromMap(result.first);
    }

    return null;
  }
} 