import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/repositories/transport/transport_write_repository.dart';

class LocalTransportWriteRepository extends TransportWriteRepository {
  final Future<Database> _database;

  LocalTransportWriteRepository(this._database);

  Future<Database> _getTransportDB() async {
    return await _database;
  }

  @override
  Future<void> updateOrCreate(Transport transport) async {
    final transportDB = await _getTransportDB();

    final existingTransport = await transportDB.query(
      'transportes',
      where: '_id = ?',
      whereArgs: [transport.id],
    );

    if (existingTransport.isNotEmpty) {
      await transportDB.update(
        'transportes',
        transport.toMap(),
        where: '_id = ?',
        whereArgs: [transport.id],
      );

      return;
    }

    await transportDB.insert('transportes', transport.toMap());
  }
} 