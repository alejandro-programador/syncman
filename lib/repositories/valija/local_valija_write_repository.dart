import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/repositories/valija/valija_write_repository.dart';

class LocalValijaWriteRepository extends ValijaWriteRepository {
  final Future<Database> _database;

  LocalValijaWriteRepository(this._database);

  Future<Database> _getValijaDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Valija valija) async {
    final valijaDB = await _getValijaDB();

    final existingValija = await valijaDB.query(
      'valijas',
      where: '_id = ?',
      whereArgs: [valija.id],
    );

    if (existingValija.isNotEmpty) {
      await valijaDB.update(
        'valijas',
        valija.toMap(),
        where: '_id = ?',
        whereArgs: [valija.id],
      );

      return;
    }

    await valijaDB.insert('valijas', valija.toMap());
  }
} 