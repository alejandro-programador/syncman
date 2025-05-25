import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/repositories/price/price_read_repository.dart';

class LocalPriceReadRepository extends PriceReadRepository {
  final Future<Database> _database;

  LocalPriceReadRepository(this._database);

  Future<Database> _getPriceDB() async {
    return await _database;
  }

  @override
  Future<List<Price>> query({
    String? updatedAt,
    int? page,
  }) async {
    final priceDB = await _getPriceDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await priceDB.query(
      'prices',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Price.fromJson(map)).toList();
  }

  @override
  Future<Price?> getById(String id) async {
    final priceDB = await _getPriceDB();

    final result = await priceDB.query(
      'prices',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Price.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<Price?> getByCodigo(String codigo) async {
    final priceDB = await _getPriceDB();

    final result = await priceDB.query(
      'prices',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Price.fromJson(result.first);
    }

    return null;
  }
} 