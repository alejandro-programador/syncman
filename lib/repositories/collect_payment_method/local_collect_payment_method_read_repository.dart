import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/repositories/collect_payment_method/collect_payment_method_read_repository.dart';

class LocalCollectPaymentMethodReadRepository extends CollectPaymentMethodReadRepository {
  final Future<Database> _database;

  LocalCollectPaymentMethodReadRepository(this._database);

  Future<Database> _getPaymentMethodDB() async {
    return await _database;
  }

  @override
  Future<List<CollectPaymentMethod>> query({
    String? updatedAt,
    int? page,
  }) async {
    print('=== LocalCollectPaymentMethodReadRepository.query ===');
    final paymentMethodDB = await _getPaymentMethodDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    print('Where clause: $whereString');
    print('Where args: $whereArgs');

    final result = await paymentMethodDB.query(
      'collect_payment_methods',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    print('=== Query Result ===');
    print('Number of records found: ${result.length}');
    for (var record in result) {
      print('Record: $record');
    }

    return result.map((map) => CollectPaymentMethod.fromMap(map)).toList();
  }

  @override
  Future<CollectPaymentMethod?> getById(String id) async {
    final paymentMethodDB = await _getPaymentMethodDB();

    final result = await paymentMethodDB.query(
      'collect_payment_methods',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return CollectPaymentMethod.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<CollectPaymentMethod?> getByDescripcion(String descripcion) async {
    final paymentMethodDB = await _getPaymentMethodDB();

    final result = await paymentMethodDB.query(
      'collect_payment_methods',
      where: 'descripcion = ?',
      whereArgs: [descripcion],
    );

    if (result.isNotEmpty) {
      return CollectPaymentMethod.fromMap(result.first);
    }

    return null;
  }
} 