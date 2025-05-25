import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/repositories/order/order_write_repository.dart';

class LocalOrderWriteRepository extends OrderWriteRepository {
  final Future<Database> _database;

  LocalOrderWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Order order) async {
    final clientDB = await _getClientDB();

    final existingClient = await clientDB.query(
      'orders',
      where: 'id = ?',
      whereArgs: [order.id],
    );

    if (existingClient.isNotEmpty) {
      await clientDB.update(
        'orders',
        order.toMap(),
        where: 'id = ?',
        whereArgs: [order.id],
      );

      return;
    }

    await clientDB.insert('orders', order.toMap());
  }
}
