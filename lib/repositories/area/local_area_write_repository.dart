import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/area/area_write_repository.dart';

class LocalAreaWriteRepository extends AreaWriteRepository {
  final Future<Database> _database;

  LocalAreaWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Area area) async {
    final clientDB = await _getClientDB();

    final existingBank = await clientDB.query(
      'areas',
      where: 'id = ?',
      whereArgs: [area.id],
    );

    if (existingBank.isNotEmpty) {
      await clientDB.update(
        'areas',
        area.toMap(),
        where: 'id = ?',
        whereArgs: [area.id],
      );

      return;
    }

    await clientDB.insert('areas', area.toMap());
  }
}
