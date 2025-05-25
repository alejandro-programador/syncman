import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/repositories/transport/transport_read_repository.dart';

class LocalTransportReadRepository extends TransportReadRepository {
  final Future<Database> _database;

  LocalTransportReadRepository(this._database);

  Future<Database> _getTransportDB() async {
    return await _database;
  }

  @override
  Future<List<Transport>> query({
    String? updatedAt,
    int? page,
  }) async {
    final transportDB = await _getTransportDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await transportDB.query(
      'transportes',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Transport.fromJson(map)).toList();
  }

  @override
  Future<Transport?> getById(String id) async {
    final transportDB = await _getTransportDB();

    final result = await transportDB.query(
      'transportes',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Transport.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<Transport?> getByCodigo(String codigo) async {
    final transportDB = await _getTransportDB();

    final result = await transportDB.query(
      'transportes',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Transport.fromJson(result.first);
    }

    return null;
  }
} 