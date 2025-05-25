import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/bank_model.dart';
import 'package:syncman_new/repositories/bank/bank_read_repository.dart';

class LocalBankReadRepository extends BankReadRepository {
  final Future<Database> _database;

  LocalBankReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<List<Bank>> query({
    String? updatedAt,
    int? page,
  }) async {
    final clientDB = await _getClientDB();

    final whereClauses = <String>[];
    final whereArgs = <String>[];

    if (updatedAt != null) {
      whereClauses.add('updatedAt >= ?');
      whereArgs.add(updatedAt);
    }

    final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    final result = await clientDB.query(
      'banks',
      where: whereString,
      orderBy: 'updatedAt ASC',
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return result.map((map) => Bank.fromMap(map)).toList();
  }

  @override
  Future<Bank?> getById(String id) async {
    final clientDB = await _getClientDB();

    final result = await clientDB.query(
      'banks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Bank.fromMap(result.first);
    }

    return null;
  }
}
