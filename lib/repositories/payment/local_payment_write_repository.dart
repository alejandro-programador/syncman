import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/repositories/payment/payment_write_repository.dart';

class LocalPaymentWriteRepository extends PaymentWriteRepository {
  final Future<Database> _database;

  LocalPaymentWriteRepository(this._database);

  Future<Database> _getPaymentDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Payment payment) async {
    final paymentDB = await _getPaymentDB();

    final existingPayment = await paymentDB.query(
      'payments',
      where: '_id = ?',
      whereArgs: [payment.id],
    );

    if (existingPayment.isNotEmpty) {
      await paymentDB.update(
        'payments',
        payment.toMap(),
        where: '_id = ?',
        whereArgs: [payment.id],
      );

      return;
    }

    await paymentDB.insert('payments', payment.toMap());
  }
} 