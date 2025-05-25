import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/bank_model.dart';
import 'package:syncman_new/repositories/bank/bank_write_repository.dart';

class LocalBankWriteRepository extends BankWriteRepository {
  final Future<Database> _database;

  LocalBankWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Bank bank) async {
    final clientDB = await _getClientDB();

    final existingBank = await clientDB.query(
      'banks',
      where: 'id = ?',
      whereArgs: [bank.id],
    );

    if (existingBank.isNotEmpty) {
      await clientDB.update(
        'banks',
        bank.toMap(),
        where: 'id = ?',
        whereArgs: [bank.id],
      );

      return;
    }

    await clientDB.insert('banks', bank.toMap());
  }
}
