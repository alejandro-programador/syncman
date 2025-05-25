import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/repositories/client/client_read_repository.dart';

class LocalClientReadRepository extends ClientReadRepository {
  final Future<Database> _database;

  LocalClientReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<List<Client>> query({
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
      'clients',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Client.fromMap(map)).toList();
  }

  @override
  Future<Client?> getById(String id) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'clients',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Client.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Client?> getByCodigo(String codigo) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'clients',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Client.fromMap(result.first);
    }

    return null;
  }
}
