import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/currency_read_repository.dart';

class LocalCurrencyReadRepository extends CurrencyReadRepository {
  final Future<Database> _database;

  LocalCurrencyReadRepository(this._database);

  Future<Database> _getCurrencyDB() async {
    return await _database;
  }

  @override
  Future<List<Currency>> query({
    String? updatedAt,
    int? page,
  }) async {
    try {
      print('=== Querying Local Currency Database ===');
      final currencyDB = await _getCurrencyDB();

      // Verificar si la tabla existe
      final tableExists = await currencyDB.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ['monedas']
      );

      if (tableExists.isEmpty) {
        print('Currency table does not exist, creating it...');
        await currencyDB.execute(Currency.createCurrencyTable);
        print('Currency table created successfully');
      }

      final whereClauses = <String>[];
      final whereArgs = <String>[];

      if (updatedAt != null) {
        whereClauses.add('updatedAt >= ?');
        whereArgs.add(updatedAt);
      }

      final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

      print('Where clause: $whereString');
      print('Where args: $whereArgs');

      final result = await currencyDB.query(
        'monedas',
        where: whereString,
        orderBy: 'updatedAt ASC',
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      );

      print('Query result count: ${result.length}');
      
      if (result.isEmpty) {
        print('No currencies found in database');
        return [];
      }

      final currencies = result.map((map) {
        try {
          print('Processing currency: ${map['nombre']}');
          return Currency.fromJson(map);
        } catch (e, stackTrace) {
          print('Error processing currency: $e');
          print('Stack trace: $stackTrace');
          print('Problematic data: $map');
          rethrow;
        }
      }).toList();

      print('Successfully processed ${currencies.length} currencies');
      return currencies;
    } catch (e, stackTrace) {
      print('Error querying currencies: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<Currency?> getById(String id) async {
    try {
      final currencyDB = await _getCurrencyDB();

      final result = await currencyDB.query(
        'monedas',
        where: '_id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        return Currency.fromJson(result.first);
      }

      return null;
    } catch (e, stackTrace) {
      print('Error getting currency by ID: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<Currency?> getByCodigo(String codigo) async {
    try {
      final currencyDB = await _getCurrencyDB();

      final result = await currencyDB.query(
        'monedas',
        where: 'codigo = ?',
        whereArgs: [codigo],
      );

      if (result.isNotEmpty) {
        return Currency.fromJson(result.first);
      }

      return null;
    } catch (e, stackTrace) {
      print('Error getting currency by code: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
} 