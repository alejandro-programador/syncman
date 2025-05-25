import 'package:sqflite/sqflite.dart';
import '../../models/tipo_precio_model.dart';
import 'tipo_precio_write_repository.dart';

class LocalTipoPrecioWriteRepository implements TipoPrecioWriteRepository {
  final Database database;

  LocalTipoPrecioWriteRepository(this.database);

  @override
  Future<void> save(TipoPrecio tipoPrecio) async {
    await database.insert(
      'tipo_precios',
      tipoPrecio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateOrCreate(TipoPrecio tipoPrecio) async {
    await database.insert(
      'tipo_precios',
      tipoPrecio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
} 