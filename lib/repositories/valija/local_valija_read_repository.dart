import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/repositories/valija/valija_read_repository.dart';

class LocalValijaReadRepository extends ValijaReadRepository {
  final Future<Database> _database;

  LocalValijaReadRepository(this._database);

  Future<Database> _getValijaDB() async {
    return await _database;
  }

  @override
  Future<List<Valija>> query({
    String? updatedAt,
    int? page,
  }) async {
    final valijaDB = await _getValijaDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await valijaDB.query(
      'valijas',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Valija.fromMap(map)).toList();
  }

  @override
  Future<Valija?> getById(String id) async {
    final valijaDB = await _getValijaDB();

    final result = await valijaDB.query(
      'valijas',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Valija.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Valija?> getByCodigo(String codigo) async {
    final valijaDB = await _getValijaDB();

    final result = await valijaDB.query(
      'valijas',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Valija.fromMap(result.first);
    }

    return null;
  }
} 