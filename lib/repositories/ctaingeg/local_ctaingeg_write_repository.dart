import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/repositories/ctaingeg/ctaingeg_write_repository.dart';

class LocalCtaIngrEgrWriteRepository extends CtaIngrEgrWriteRepository {
  final Future<Database> _database;

  LocalCtaIngrEgrWriteRepository(this._database);

  Future<Database> _getCtaIngrEgrDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(CtaIngrEgr ctaIngrEgr) async {
    final ctaIngrEgrDB = await _getCtaIngrEgrDB();

    final existingCtaIngrEgr = await ctaIngrEgrDB.query(
      'cta_ingr_egr',
      where: '_id = ?',
      whereArgs: [ctaIngrEgr.id],
    );

    if (existingCtaIngrEgr.isNotEmpty) {
      await ctaIngrEgrDB.update(
        'cta_ingr_egr',
        ctaIngrEgr.toMap(),
        where: '_id = ?',
        whereArgs: [ctaIngrEgr.id],
      );

      return;
    }

    await ctaIngrEgrDB.insert('cta_ingr_egr', ctaIngrEgr.toMap());
  }
} 