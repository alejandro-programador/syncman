import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/repositories/ctaingeg/ctaingeg_read_repository.dart';

class LocalCtaIngrEgrReadRepository extends CtaIngrEgrReadRepository {
  final Future<Database> _database;

  LocalCtaIngrEgrReadRepository(this._database);

  Future<Database> _getCtaIngrEgrDB() async {
    return await _database;
  }

  @override
  Future<List<CtaIngrEgr>> query({String? updatedAt, int? page}) async {
    final ctaIngrEgrDB = await _getCtaIngrEgrDB();

    final List<Map<String, dynamic>> maps = await ctaIngrEgrDB.query(
      'cta_ingr_egr',
      where: updatedAt != null ? 'updatedAt > ?' : null,
      whereArgs: updatedAt != null ? [updatedAt] : null,
      limit: page != null ? 20 : null,
      offset: page != null ? (page - 1) * 20 : null,
    );

    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      map['datosAdicionales'] = jsonDecode(map['datosAdicionales']);
      return CtaIngrEgr.fromJson(map);
    });
  }

  @override
  Future<CtaIngrEgr?> getById(String id) async {
    final ctaIngrEgrDB = await _getCtaIngrEgrDB();

    final List<Map<String, dynamic>> maps = await ctaIngrEgrDB.query(
      'cta_ingr_egr',
      where: '_id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = Map<String, dynamic>.from(maps.first);
    map['datosAdicionales'] = jsonDecode(map['datosAdicionales']);
    return CtaIngrEgr.fromJson(map);
  }

  @override
  Future<CtaIngrEgr?> getByCodigo(String codigo) async {
    final ctaIngrEgrDB = await _getCtaIngrEgrDB();

    final List<Map<String, dynamic>> maps = await ctaIngrEgrDB.query(
      'cta_ingr_egr',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = Map<String, dynamic>.from(maps.first);
    map['datosAdicionales'] = jsonDecode(map['datosAdicionales']);
    return CtaIngrEgr.fromJson(map);
  }
} 