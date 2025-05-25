import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/repositories/order/order_read_repository.dart';

class LocalOrderReadRepository extends OrderReadRepository {
  final Future<Database> _database;

  LocalOrderReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<List<Order>> query({
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
      'orders',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Order.fromMap(map)).toList();
  }

  @override
  Future<Order?> getById(String id) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Order.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Order?> getByCodigo(String codigo) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'orders',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Order.fromMap(result.first);
    }

    return null;
  }
}
