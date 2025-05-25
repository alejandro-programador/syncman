import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/repositories/bill/bill_write_repository.dart';

class LocalBillWriteRepository extends BillWriteRepository {
  final Future<Database> _database;

  LocalBillWriteRepository(this._database);

  Future<Database> _getBillDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Bill bill) async {
    final billDB = await _getBillDB();

    final existingBill = await billDB.query(
      'bills',
      where: '_id = ?',
      whereArgs: [bill.id],
    );

    if (existingBill.isNotEmpty) {
      await billDB.update(
        'bills',
        bill.toMap(),
        where: '_id = ?',
        whereArgs: [bill.id],
      );

      return;
    }

    await billDB.insert('bills', bill.toMap());
  }
} 