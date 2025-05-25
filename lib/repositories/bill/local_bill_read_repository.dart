import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/repositories/bill/bill_read_repository.dart';
import 'dart:convert';

class LocalBillReadRepository extends BillReadRepository {
  final Future<Database> _database;

  LocalBillReadRepository(this._database);

  Future<Database> _getBillDB() async {
    return await _database;
  }

  @override
  Future<List<Bill>> query({
    String? updatedAt,
    int? page,
  }) async {
    final billDB = await _getBillDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await billDB.query(
      'bills',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    return result.map((map) => Bill.fromMap(map)).toList();
  }

  @override
  Future<Bill?> getById(String id) async {
    final billDB = await _getBillDB();

    final result = await billDB.query(
      'bills',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Bill.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<Bill?> getByCodigo(String codigo) async {
    final billDB = await _getBillDB();

    final result = await billDB.query(
      'bills',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return Bill.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<List<Bill>> getByClientId(String clientId, {int page = 0, int pageSize = 20}) async {
    final billDB = await _getBillDB();

    try {
      // Get all bills without pagination
      final result = await billDB.query(
        'bills',
        // Remove limit and offset to get all bills
      );

      
      // Filter bills where client._id matches the provided clientId
      final bills = result.map((map) {
        try {
          // Parse the client data from JSON string
          Map<String, dynamic> clientData;
          final cliente = map['cliente'];
          if (cliente is String) {
            clientData = json.decode(cliente);
          } else if (cliente is Map) {
            clientData = Map<String, dynamic>.from(cliente);
          } else {
            return null;
          }

          // Check if this bill belongs to the requested client
          if (clientData['_id'] == clientId) {
            final bill = Bill.fromMap(map);
            return bill;
          }
          return null;
        } catch (e) {
          return null;
        }
      }).where((bill) => bill != null).cast<Bill>().toList();

      return bills;
    } catch (e) {
      rethrow;
    }
  }
} 