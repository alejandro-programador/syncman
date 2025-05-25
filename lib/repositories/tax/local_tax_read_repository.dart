import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/repositories/tax/tax_read_repository.dart';

class LocalTaxReadRepository extends TaxReadRepository {
  final Future<Database> _database;

  LocalTaxReadRepository(this._database);

  Future<Database> _getTaxDB() async {
    return await _database;
  }

  @override
  Future<List<Tax>> getAllTaxes() async {
    final taxDB = await _getTaxDB();
    final List<Map<String, dynamic>> maps = await taxDB.query('impuestos');
    return List.generate(maps.length, (i) {
      return Tax.fromJson(maps[i]);
    });
  }

  @override
  Future<Tax?> getTaxById(String id) async {
    final taxDB = await _getTaxDB();
    final List<Map<String, dynamic>> maps = await taxDB.query(
      'impuestos',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Tax.fromJson(maps.first);
  }

  @override
  Future<List<Tax>> getTaxesByDate(String date) async {
    final taxDB = await _getTaxDB();
    final List<Map<String, dynamic>> maps = await taxDB.query(
      'impuestos',
      where: 'fecha = ?',
      whereArgs: [date],
    );

    return List.generate(maps.length, (i) {
      return Tax.fromJson(maps[i]);
    });
  }
} 