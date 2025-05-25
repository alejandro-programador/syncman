import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/repositories/price/price_write_repository.dart';

class LocalPriceWriteRepository extends PriceWriteRepository {
  final Future<Database> _database;

  LocalPriceWriteRepository(this._database);

  Future<Database> _getPriceDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Price price) async {
    final priceDB = await _getPriceDB();

    final existingPrice = await priceDB.query(
      'prices',
      where: '_id = ?',
      whereArgs: [price.id],
    );

    if (existingPrice.isNotEmpty) {
      await priceDB.update(
        'prices',
        price.toMap(),
        where: '_id = ?',
        whereArgs: [price.id],
      );

      return;
    }

    await priceDB.insert('prices', price.toMap());
  }
} 