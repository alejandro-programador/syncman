import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/repositories/payment/payment_read_repository.dart';

class LocalPaymentReadRepository extends PaymentReadRepository {
  final Future<Database> _database;

  LocalPaymentReadRepository(this._database);

  Future<Database> _getPaymentDB() async {
    return await _database;
  }

  bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      if (value == '1' || value.toLowerCase() == 'true') return true;
      if (value == '0' || value.toLowerCase() == 'false') return false;
    }
    return false;
  }

  Map<String, dynamic> _convertBooleanFields(Map<String, dynamic> map) {
    final convertedMap = Map<String, dynamic>.from(map);
    
    // Convert main boolean fields
    if (convertedMap['valija'] is int) {
      convertedMap['valija'] = convertedMap['valija'] == 1;
    }
    if (convertedMap['isDeleted'] is int) {
      convertedMap['isDeleted'] = convertedMap['isDeleted'] == 1;
    }

    // Parse and convert nested JSON structures
    if (convertedMap['metodosPago'] is String) {
      try {
        final List<dynamic> metodosPago = jsonDecode(convertedMap['metodosPago']);
        convertedMap['metodosPago'] = metodosPago;
      } catch (e) {
        convertedMap['metodosPago'] = [];
      }
    }

    if (convertedMap['facturas'] is String) {
      try {
        final List<dynamic> facturas = jsonDecode(convertedMap['facturas']);
        convertedMap['facturas'] = facturas;
      } catch (e) {
        convertedMap['facturas'] = [];
      }
    }

    if (convertedMap['cliente'] is String) {
      try {
        final Map<String, dynamic> cliente = jsonDecode(convertedMap['cliente']);
        // Convert boolean fields in cliente
        if (cliente['recent'] != null) cliente['recent'] = _parseBool(cliente['recent']);
        if (cliente['contrib'] != null) cliente['contrib'] = _parseBool(cliente['contrib']);
        convertedMap['cliente'] = cliente;
      } catch (e) {
        convertedMap['cliente'] = {};
      }
    }

    if (convertedMap['vendedor'] is String) {
      try {
        final Map<String, dynamic> vendedor = jsonDecode(convertedMap['vendedor']);
        // Convert boolean fields in vendedor
        if (vendedor['inactivo'] != null) vendedor['inactivo'] = _parseBool(vendedor['inactivo']);
        if (vendedor['funCob'] != null) vendedor['funCob'] = _parseBool(vendedor['funCob']);
        if (vendedor['funVen'] != null) vendedor['funVen'] = _parseBool(vendedor['funVen']);
        if (vendedor['isDeleted'] != null) vendedor['isDeleted'] = _parseBool(vendedor['isDeleted']);
        convertedMap['vendedor'] = vendedor;
      } catch (e) {
        convertedMap['vendedor'] = {};
      }
    }

    return convertedMap;
  }

  @override
  Future<List<Payment>> query({
    String? updatedAt,
    int? page,
  }) async {
    try {
      final paymentDB = await _getPaymentDB();

      final whereClauses = <String>[];
      final whereArgs = <dynamic>[];

      if (updatedAt != null) {
        whereClauses.add('updatedAt >= ?');
        whereArgs.add(updatedAt);
      }

      final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

      final result = await paymentDB.query(
        'payments',
        where: whereString,
        orderBy: 'updatedAt ASC',
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      );

      return result.map((map) {
        try {
          final convertedMap = _convertBooleanFields(map);
          return Payment.fromMap(convertedMap);
        } catch (e) {
          rethrow;
        }
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Payment?> getById(String id) async {
    try {
      final paymentDB = await _getPaymentDB();

      final result = await paymentDB.query(
        'payments',
        where: '_id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        final convertedMap = _convertBooleanFields(result.first);
        return Payment.fromMap(convertedMap);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Payment?> getByCodigo(String codigo) async {
    try {
      final paymentDB = await _getPaymentDB();

      final result = await paymentDB.query(
        'payments',
        where: 'codigo = ?',
        whereArgs: [codigo],
      );

      if (result.isNotEmpty) {
        final convertedMap = _convertBooleanFields(result.first);
        return Payment.fromMap(convertedMap);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
} 