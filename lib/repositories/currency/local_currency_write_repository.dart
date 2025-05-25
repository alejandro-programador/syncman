import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/currency_write_repository.dart';

class LocalCurrencyWriteRepository extends CurrencyWriteRepository {
  final Future<Database> _database;

  LocalCurrencyWriteRepository(this._database);

  Future<Database> _getCurrencyDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Currency currency) async {
    final currencyDB = await _getCurrencyDB();

    final existingCurrency = await currencyDB.query(
      'monedas',
      where: '_id = ?',
      whereArgs: [currency.id],
    );

    if (existingCurrency.isNotEmpty) {
      await currencyDB.update(
        'monedas',
        currency.toMap(),
        where: '_id = ?',
        whereArgs: [currency.id],
      );

      return;
    }

    await currencyDB.insert('monedas', currency.toMap());
  }
} 