import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/repositories/return-record/return_record_write_repository.dart';

class LocalReturnRecordWriteRepository extends ReturnRecordWriteRepository {
  final Database _database;

  LocalReturnRecordWriteRepository(this._database);

  @override
  Future<void> updateOrCreate(ReturnRecord record) async {
    final map = record.toJson();
    
    // Convert complex objects to JSON strings
    map['vendedor'] = jsonEncode(map['vendedor']);
    map['cliente'] = jsonEncode(map['cliente']);
    map['factura'] = jsonEncode(map['factura']);
    map['productos'] = jsonEncode(map['productos']);
    map['imagenes'] = jsonEncode(map['imagenes']);
    
    // Convert boolean to integer
    map['isDeleted'] = map['isDeleted'] ? 1 : 0;

    await _database.insert(
      'return_records',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(String id) async {
    await _database.delete(
      'return_records',
      where: '_id = ?',
      whereArgs: [id],
    );
  }
} 