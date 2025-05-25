import 'package:sqflite/sqflite.dart';
import '../../models/tipo_precio_model.dart';
import 'tipo_precio_read_repository.dart';

class LocalTipoPrecioReadRepository extends TipoPrecioReadRepository {
  final Database database;

  LocalTipoPrecioReadRepository(this.database);

  @override
  Future<List<TipoPrecio>> query({
    String? updatedAt,
    int? page,
  }) async {
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (updatedAt != null) {
      whereClause = 'updatedAt > ?';
      whereArgs.add(updatedAt);
    }

    final List<Map<String, dynamic>> maps = await database.query(
      'tipo_precios',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'updatedAt DESC',
    );

    return List.generate(maps.length, (i) => TipoPrecio.fromMap(maps[i]));
  }

  @override
  Future<TipoPrecio?> getById(String id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'tipo_precios',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return TipoPrecio.fromMap(maps.first);
  }

  @override
  Future<TipoPrecio?> getByCodigo(String codigo) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'tipo_precios',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (maps.isEmpty) {
      return null;
    }

    return TipoPrecio.fromMap(maps.first);
  }
} 