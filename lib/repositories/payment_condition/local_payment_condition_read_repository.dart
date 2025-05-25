import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/repositories/payment_condition/payment_condition_read_repository.dart';

class LocalPaymentConditionReadRepository extends PaymentConditionReadRepository {
  final Future<Database> _database;

  LocalPaymentConditionReadRepository(this._database);

  Future<Database> _getPaymentConditionDB() async {
    return await _database;
  }

  @override
  Future<List<PaymentCondition>> query({
    String? updatedAt,
    int? page,
  }) async {
    final paymentConditionDB = await _getPaymentConditionDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await paymentConditionDB.query(
      'condicion_pagos',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => PaymentCondition.fromJson(map)).toList();
  }

  @override
  Future<PaymentCondition?> getById(String id) async {
    final paymentConditionDB = await _getPaymentConditionDB();

    final result = await paymentConditionDB.query(
      'condicion_pagos',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return PaymentCondition.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PaymentCondition?> getByCodigo(String codigo) async {
    final paymentConditionDB = await _getPaymentConditionDB();

    final result = await paymentConditionDB.query(
      'condicion_pagos',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return PaymentCondition.fromJson(result.first);
    }

    return null;
  }
} 