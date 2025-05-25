import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/repositories/return-record/return_record_read_repository.dart';

class LocalReturnRecordReadRepository extends ReturnRecordReadRepository {
  final Future<Database> _database;

  LocalReturnRecordReadRepository(this._database);

  Future<Database> _getReturnRecordDB() async {
    return await _database;
  }

  @override
  Future<List<ReturnRecord>> query({String? updatedAt, int? page}) async {
    final db = await _getReturnRecordDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'return_records',
      where: updatedAt != null ? 'updatedAt > ?' : null,
      whereArgs: updatedAt != null ? [updatedAt] : null,
      orderBy: 'updatedAt ASC',
    );

    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      
      // Parse JSON strings back to objects
      map['vendedor'] = jsonDecode(map['vendedor'] as String);
      map['cliente'] = jsonDecode(map['cliente'] as String);
      map['factura'] = jsonDecode(map['factura'] as String);
      map['productos'] = jsonDecode(map['productos'] as String);
      map['imagenes'] = jsonDecode(map['imagenes'] as String);
      
      // Convert integer back to boolean
      map['isDeleted'] = map['isDeleted'] == 1;

      return ReturnRecord.fromJson(map);
    });
  }

  @override
  Future<ReturnRecord?> getById(String id) async {
    final db = await _getReturnRecordDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'return_records',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    final map = Map<String, dynamic>.from(maps.first);
    
    // Parse JSON strings back to objects
    map['vendedor'] = jsonDecode(map['vendedor'] as String);
    map['cliente'] = jsonDecode(map['cliente'] as String);
    map['factura'] = jsonDecode(map['factura'] as String);
    map['productos'] = jsonDecode(map['productos'] as String);
    map['imagenes'] = jsonDecode(map['imagenes'] as String);
    
    // Convert integer back to boolean
    map['isDeleted'] = map['isDeleted'] == 1;

    return ReturnRecord.fromJson(map);
  }

  @override
  Future<ReturnRecord?> getByCodigo(String codigo) async {
    final db = await _getReturnRecordDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'return_records',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (maps.isEmpty) return null;

    final map = Map<String, dynamic>.from(maps.first);
    
    // Parse JSON strings back to objects
    map['vendedor'] = jsonDecode(map['vendedor'] as String);
    map['cliente'] = jsonDecode(map['cliente'] as String);
    map['factura'] = jsonDecode(map['factura'] as String);
    map['productos'] = jsonDecode(map['productos'] as String);
    map['imagenes'] = jsonDecode(map['imagenes'] as String);
    
    // Convert integer back to boolean
    map['isDeleted'] = map['isDeleted'] == 1;

    return ReturnRecord.fromJson(map);
  }
} 