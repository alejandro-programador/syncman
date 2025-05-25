import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/repositories/configuration/configuration_write_repository.dart';

class LocalConfigurationWriteRepository extends ConfigurationWriteRepository {
  final Future<Database> _database;

  LocalConfigurationWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Configuration configuration) async {
    final clientDB = await _getClientDB();
    await clientDB.insert(
      'config_app',
      configuration.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
