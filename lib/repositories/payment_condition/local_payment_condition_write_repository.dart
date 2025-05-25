import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/repositories/payment_condition/payment_condition_write_repository.dart';

class LocalPaymentConditionWriteRepository extends PaymentConditionWriteRepository {
  final Future<Database> _database;

  LocalPaymentConditionWriteRepository(this._database);

  Future<Database> _getPaymentConditionDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(PaymentCondition paymentCondition) async {
    final paymentConditionDB = await _getPaymentConditionDB();

    final existingPaymentCondition = await paymentConditionDB.query(
      'condicion_pagos',
      where: '_id = ?',
      whereArgs: [paymentCondition.id],
    );

    if (existingPaymentCondition.isNotEmpty) {
      await paymentConditionDB.update(
        'condicion_pagos',
        paymentCondition.toMap(),
        where: '_id = ?',
        whereArgs: [paymentCondition.id],
      );

      return;
    }

    await paymentConditionDB.insert('condicion_pagos', paymentCondition.toMap());
  }
} 