import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/repositories/seller/seller_read_repository.dart';

class LocalSellerReadRepository extends SellerReadRepository {
  final Future<Database> _database;

  LocalSellerReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<List<Seller>> query({
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
      'sellers',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Seller.fromMap(map)).toList();
  }

  @override
  Future<Seller?> getById(String id) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'sellers',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Seller.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Seller?> getByCodigo(String codigo) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'sellers',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Seller.fromMap(result.first);
    }

    return null;
  }
}
