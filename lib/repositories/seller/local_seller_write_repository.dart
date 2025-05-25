import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/repositories/seller/seller_write_repository.dart';

class LocalSellerWriteRepository extends SellerWriteRepository {
  final Future<Database> _database;

  LocalSellerWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Seller seller) async {
    final clientDB = await _getClientDB();

    final existingSeller = await clientDB.query(
      'sellers',
      where: 'id = ?',
      whereArgs: [seller.id],
    );

    if (existingSeller.isNotEmpty) {
      await clientDB.update(
        'sellers',
        seller.toMap(),
        where: 'id = ?',
        whereArgs: [seller.id],
      );

      return;
    }

    await clientDB.insert('sellers', seller.toMap());
  }
}
