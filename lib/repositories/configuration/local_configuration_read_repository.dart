import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/repositories/configuration/configuration_read_repository.dart';

class LocalConfigurationReadRepository extends ConfigurationReadRepository {
  final Future<Database> _database;

  LocalConfigurationReadRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<Configuration?> get() async {
    final clientDB = await _getClientDB();
    final result = await clientDB.query('config_app');

    if (result.isEmpty) return null;

    final original = result.first;
    final config = Map<String, dynamic>.from(original);

    config['configuracion'] = jsonDecode(config['configuracion'] as String);

    final configuration = Configuration.fromJson(config);
    return configuration;
  }
}
