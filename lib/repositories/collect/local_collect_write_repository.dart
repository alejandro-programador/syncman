import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/repositories/collect/collect_write_repository.dart';

class LocalCollectWriteRepository extends CollectWriteRepository {
  final Future<Database> _database;

  LocalCollectWriteRepository(this._database);

  Future<Database> _getCollectDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Collect collect) async {
    final collectDB = await _getCollectDB();
    await collectDB.insert(
      'collects',
      collect.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
} 