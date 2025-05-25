import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/repositories/collect_payment_method/collect_payment_method_write_repository.dart';

class LocalCollectPaymentMethodWriteRepository extends CollectPaymentMethodWriteRepository {
  final Future<Database> _database;

  LocalCollectPaymentMethodWriteRepository(this._database);

  Future<Database> _getPaymentMethodDB() async {
    return await _database;
  }

  @override
  Future<void> create(CollectPaymentMethod paymentMethod) async {
    try {
      final paymentMethodDB = await _getPaymentMethodDB();
      await paymentMethodDB.insert(
        'collect_payment_methods',
        paymentMethod.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error creating payment method: $e');
      rethrow;
    }
  }

  @override
  Future<void> update(CollectPaymentMethod paymentMethod) async {
    try {
      final paymentMethodDB = await _getPaymentMethodDB();
      await paymentMethodDB.update(
        'collect_payment_methods',
        paymentMethod.toMap(),
        where: '_id = ?',
        whereArgs: [paymentMethod.id],
      );
    } catch (e) {
      print('Error updating payment method: $e');
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final paymentMethodDB = await _getPaymentMethodDB();
      await paymentMethodDB.update(
        'collect_payment_methods',
        {'isDeleted': 1},
        where: '_id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting payment method: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateOrCreate(CollectPaymentMethod paymentMethod) async {
    final paymentMethodDB = await _getPaymentMethodDB();

    final existingPaymentMethod = await paymentMethodDB.query(
      'collect_payment_methods',
      where: '_id = ?',
      whereArgs: [paymentMethod.id],
    );

    if (existingPaymentMethod.isNotEmpty) {
      await paymentMethodDB.update(
        'collect_payment_methods',
        paymentMethod.toMap(),
        where: '_id = ?',
        whereArgs: [paymentMethod.id],
      );

      return;
    }

    await paymentMethodDB.insert('collect_payment_methods', paymentMethod.toMap());
  }
} 