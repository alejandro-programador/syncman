import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/repositories/tax/tax_write_repository.dart';

class LocalTaxWriteRepository extends TaxWriteRepository {
  final Future<Database> _database;

  LocalTaxWriteRepository(this._database);

  Future<Database> _getTaxDB() async {
    return await _database;
  }

  @override
  Future<void> createTax(Tax tax) async {
    final taxDB = await _getTaxDB();
    await taxDB.insert(
      'impuestos',
      tax.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTax(Tax tax) async {
    final taxDB = await _getTaxDB();
    await taxDB.update(
      'impuestos',
      tax.toMap(),
      where: '_id = ?',
      whereArgs: [tax.id],
    );
  }

  @override
  Future<void> deleteTax(String id) async {
    final taxDB = await _getTaxDB();
    await taxDB.update(
      'impuestos',
      {'isDeleted': 1, 'deletedAt': DateTime.now().toIso8601String()},
      where: '_id = ?',
      whereArgs: [id],
    );
  }
} 