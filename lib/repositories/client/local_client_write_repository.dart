import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/repositories/client/client_write_repository.dart';

class LocalClientWriteRepository extends ClientWriteRepository {
  final Future<Database> _database;

  LocalClientWriteRepository(this._database);

  Future<Database> _getClientDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Client client) async {
    final clientDB = await _getClientDB();

    final existingClient = await clientDB.query(
      'clients',
      where: 'id = ?',
      whereArgs: [client.id],
    );

    if (existingClient.isNotEmpty) {
      await clientDB.update(
        'clients',
        client.toMap(),
        where: 'id = ?',
        whereArgs: [client.id],
      );

      return;
    }

    await clientDB.insert('clients', client.toMap());
  }
}
